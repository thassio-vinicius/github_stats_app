import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stats_app/core/errors/failures.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
import 'package:github_stats_app/features/repo_stats/data/data_source/repo_stats_data_source.dart';
import 'package:github_stats_app/features/repo_stats/data/models/repo_files_model.dart';
import 'package:github_stats_app/features/repo_stats/domain/entities/repo_files_entity.dart';
import 'package:github_stats_app/features/repo_stats/domain/repository/repo_stats_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoStatsDataSource extends Mock implements RepoStatsDataSource {}

void main() {
  late MockRepoStatsDataSource mockDataSource;
  late RepoStatsRepositoryImpl repository;
  const repoName = 'test_repo';
  const repoOwner = 'test_owner';
  const branch = 'main';
  final languages = [ProgrammingLanguage.dart];

  setUp(() {
    mockDataSource = MockRepoStatsDataSource();
    repository = RepoStatsRepositoryImpl(mockDataSource);
    registerFallbackValue(const RepoFilesEntity().languageFiles(languages));
  });

  group('fetchLettersCount', () {
    test('should return NoResultsForLanguageFailure when no files', () async {
      when(() => mockDataSource.getRepo(repoName, repoOwner, branch))
          .thenAnswer((_) async => RepoFilesModel());

      final result = await repository.fetchLettersCount(
        repoName: repoName,
        repoOwner: repoOwner,
        branch: branch,
        languages: languages,
      );

      expect(result, const Left(NoResultsForLanguageFailure()));
      expect(result, const Left(NoResultsForLanguageFailure()));

      verify(() => mockDataSource.getRepo(repoName, repoOwner, branch))
          .called(1);
      verifyNever(() => mockDataSource.getFileContent(
            any(),
            any(),
            any(),
            any(),
          ));
    });

    test('should return GenericFailure on exception', () async {
      when(() => mockDataSource.getRepo(repoName, repoOwner, branch))
          .thenThrow(Exception('Test exception'));

      final result = await repository.fetchLettersCount(
        repoName: repoName,
        repoOwner: repoOwner,
        branch: branch,
        languages: languages,
      );

      result.fold(
        (failure) => expect(failure, isA<GenericFailure>()),
        (_) => fail('Expected left but got right'),
      );

      verify(() => mockDataSource.getRepo(repoName, repoOwner, branch))
          .called(1);
      verifyNever(() => mockDataSource.getFileContent(
            any(),
            any(),
            any(),
            any(),
          ));
    });
  });

  group('Helper Methods', () {
    test('countLettersInFiles should correctly count letters', () {
      final fileContents = ['test content', 'another test'];
      final expectedCount = {
        't': 7,
        'e': 4,
        's': 2,
        'c': 1,
        'o': 2,
        'n': 3,
        'a': 1,
        'h': 1,
        'r': 1,
      };

      final result = RepoStatsRepositoryImpl.countLettersInFiles(fileContents);

      expect(result, expectedCount);
    });

    test('countLetters should correctly count letters in a single string', () {
      const content = 'test content';
      final expectedCount = {
        't': 4,
        'e': 2,
        's': 1,
        'c': 1,
        'o': 1,
        'n': 2,
      };

      final result = RepoStatsRepositoryImpl.countLetters(content);

      expect(result, expectedCount);
    });

    test('mergeCounts should correctly merge two maps', () {
      final counts1 = {'a': 1, 'b': 2};
      final counts2 = {'b': 3, 'c': 1};
      final expectedCount = {'a': 1, 'b': 5, 'c': 1};

      final result = RepoStatsRepositoryImpl.mergeCounts(counts1, counts2);

      expect(result, expectedCount);
    });
  });
}
