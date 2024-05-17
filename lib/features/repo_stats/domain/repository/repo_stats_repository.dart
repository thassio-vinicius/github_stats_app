import 'package:dartz/dartz.dart';
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
        final responses =
            await _getFileContents(repoName, repoOwner, jsTsFiles);

        print('WENT HERE ');

        responses.fold((l) {
          print('ERROR FOLD' + l.toString());
          return Left(Exception());
        }, (r) {
          print('FILES LENGTH ' + r.length.toString());
          for (var file in r) {
            final counts = _countLetters(file);
            totalCounts = _mergeCounts(totalCounts, counts);
          }
        });
      }

      return Right(totalCounts);
    } catch (e) {
      print('ERROR IS ' + e.toString());

      return Left(Exception());
    }
  }

  Future<Either<Exception, List<String>>> _getFileContents(
    String repoName,
    String repoOwner,
    List<RepoTreeEntity> jsTsFiles,
  ) async {
    try {
      final futures = <Future<String>>[];

      for (var file in jsTsFiles) {
        futures.add(
          _dataSource.getFileContent(
            repoName,
            repoOwner,
            file.path!,
          ),
        );
      }

      final List<String> responses = await Future.wait(futures);

      return Right(responses);
    } catch (e) {
      print('ERROR IS ' + e.toString());
      return Left(Exception());
    }
  }

  Map<String, int> _countLetters(String content) {
    Map<String, int> letterCounts = {};

    for (var char in content.runes) {
      var letter = String.fromCharCode(char).toLowerCase();
      if (letter.contains(RegExp(r'[a-z]'))) {
        letterCounts[letter] = (letterCounts[letter] ?? 0) + 1;
      }
    }

    return letterCounts;
  }

  Map<String, int> _mergeCounts(
    Map<String, int> totalCounts,
    Map<String, int> newCounts,
  ) {
    newCounts.forEach((key, value) {
      totalCounts[key] = (totalCounts[key] ?? 0) + value;
    });
    return totalCounts;
  }
}
