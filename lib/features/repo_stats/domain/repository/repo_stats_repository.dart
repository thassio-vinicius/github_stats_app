import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:github_stats_app/features/repo_stats/data/data_source/repo_stats_data_source.dart';
import 'package:github_stats_app/features/repo_stats/domain/entities/repo_files_entity.dart';
import 'package:github_stats_app/features/repo_stats/domain/entities/repo_tree_entity.dart';

abstract class RepoStatsRepository {
  const RepoStatsRepository();
  Future<Either<Exception, Map<String, int>>> fetchLettersCount(
    String repoName,
    String repoOwner,
  );
}

class RepoStatsRepositoryImpl extends RepoStatsRepository {
  final RepoStatsDataSource _dataSource;
  const RepoStatsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Exception, Map<String, int>>> fetchLettersCount(
    String repoName,
    String repoOwner,
  ) async {
    try {
      final response = await _dataSource.getRepo(repoName, repoOwner);
      final entity = RepoFilesEntity.fromModel(response);
      final jsTsFiles = entity.jsTsFiles();
      Map<String, int> totalCounts = {};

      if (jsTsFiles.isNotEmpty) {
        // Process files in batches
        const batchSize = 50;
        for (int i = 0; i < jsTsFiles.length; i += batchSize) {
          final batchFiles = jsTsFiles.skip(i).take(batchSize).toList();
          final fileContentsResult =
              await _getFileContents(repoName, repoOwner, batchFiles);

          fileContentsResult.fold((l) {
            return Left(Exception());
          }, (fileContents) async {
            final batchCounts =
                await compute(_countLettersInFiles, fileContents);
            totalCounts = _mergeCounts(totalCounts, batchCounts);
          });
        }
      }

      return Right(totalCounts);
    } catch (e) {
      return Left(Exception());
    }
  }

  Future<Either<Exception, List<String>>> _getFileContents(
    String repoName,
    String repoOwner,
    List<RepoTreeEntity> jsTsFiles,
  ) async {
    try {
      final futures = jsTsFiles
          .map(
            (file) =>
                _dataSource.getFileContent(repoName, repoOwner, file.path!),
          )
          .toList();

      final List<String> responses = await Future.wait(futures);
      return Right(responses);
    } catch (e) {
      return Left(Exception());
    }
  }

  static Map<String, int> _countLettersInFiles(List<String> fileContents) {
    Map<String, int> totalCounts = {};

    for (String content in fileContents) {
      Map<String, int> letterCounts = _countLetters(content);
      totalCounts = _mergeCounts(totalCounts, letterCounts);
    }

    return totalCounts;
  }

  static Map<String, int> _countLetters(String content) {
    Map<String, int> letterCounts = {};

    for (var char in content.runes) {
      var letter = String.fromCharCode(char).toLowerCase();
      if (letter.contains(RegExp(r'[a-z]'))) {
        letterCounts[letter] = (letterCounts[letter] ?? 0) + 1;
      }
    }

    return letterCounts;
  }

  static Map<String, int> _mergeCounts(
    Map<String, int> totalCounts,
    Map<String, int> newCounts,
  ) {
    newCounts.forEach((key, value) {
      totalCounts[key] = (totalCounts[key] ?? 0) + value;
    });
    return totalCounts;
  }
}
