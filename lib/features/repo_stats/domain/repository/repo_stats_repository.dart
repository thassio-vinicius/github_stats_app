import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:github_stats_app/core/errors/failure.dart';
import 'package:github_stats_app/core/errors/failures.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
import 'package:github_stats_app/features/repo_stats/data/data_source/repo_stats_data_source.dart';
import 'package:github_stats_app/features/repo_stats/domain/entities/repo_files_entity.dart';
import 'package:github_stats_app/features/repo_stats/domain/entities/repo_tree_entity.dart';

abstract class RepoStatsRepository {
  const RepoStatsRepository();
  Future<Either<Failure, Map<String, int>>> fetchLettersCount({
    required String repoName,
    required String repoOwner,
    required String branch,
    required List<ProgrammingLanguage> languages,
  });
}

class RepoStatsRepositoryImpl extends RepoStatsRepository {
  final RepoStatsDataSource _dataSource;
  const RepoStatsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Map<String, int>>> fetchLettersCount({
    required String repoName,
    required String branch,
    required String repoOwner,
    required List<ProgrammingLanguage> languages,
  }) async {
    try {
      final response = await _dataSource.getRepo(repoName, repoOwner, branch);
      final entity = RepoFilesEntity.fromModel(response);
      final languageFiles = entity.languageFiles(languages);
      Map<String, int> totalCounts = {};

      if (languageFiles.isNotEmpty) {
        const batchSize = 50;
        for (int i = 0; i < languageFiles.length; i += batchSize) {
          final batchFiles = languageFiles.skip(i).take(batchSize).toList();
          final fileContentsResult = await _getFileContents(
            repoName,
            repoOwner,
            batchFiles,
            branch,
          );

          fileContentsResult.fold((l) {
            return Left(GenericFailure(l.message));
          }, (fileContents) async {
            final batchCounts =
                await compute(_countLettersInFiles, fileContents);
            totalCounts = _mergeCounts(totalCounts, batchCounts);
          });
        }
      } else {
        return const Left(NoResultsForLanguageFailure());
      }

      return Right(totalCounts);
    } catch (e) {
      if (e is FormatException) return const Left(NoRepositoriesFailure());
      return Left(GenericFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> _getFileContents(
    String repoName,
    String repoOwner,
    List<RepoTreeEntity> languageFiles,
    String branch,
  ) async {
    try {
      final futures = languageFiles
          .map(
            (file) => _dataSource.getFileContent(
              repoName,
              repoOwner,
              file.path!,
              branch,
            ),
          )
          .toList();

      final List<String> responses = await Future.wait(futures);
      return Right(responses);
    } catch (e) {
      return Left(GenericFailure(e.toString()));
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
