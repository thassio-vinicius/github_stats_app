import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stats_app/core/errors/failures.dart';
import 'package:github_stats_app/features/repo_stats/domain/repository/repo_stats_repository.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_cubit.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_state.dart';
import 'package:github_stats_app/features/repo_stats/presentation/repo_stats_results_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockRepoStatsRepository extends Mock implements RepoStatsRepository {}

void main() {
  late RepoStatsCubit cubit;
  late MockRepoStatsRepository mockRepository;

  setUp(() {
    mockRepository = MockRepoStatsRepository();
    cubit = RepoStatsCubit(mockRepository);
  });

  const args = RepoStatsArgs(
    repoName: 'test_repo',
    repoOwner: 'test_owner',
    branch: 'main',
    languages: [],
  );

  group('fetchStats', () {
    test(
        'emits [RepoStatsLoadingState, RepoStatsLoadedState] on successful fetch',
        () async {
      const response = FetchCountsResponse(
        filesCount: 1,
        totalLettersCount: {'a': 1},
      );

      when(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).thenAnswer((_) async => const Right(response));

      final expectedStates = [
        const RepoStatsLoadingState(),
        RepoStatsLoadedState(
          totalLettersCount: response.totalLettersCount,
          filesCount: response.filesCount,
        ),
      ];
      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.fetchStats(args);

      verify(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).called(1);
    });

    test('emits [RepoStatsLoadingState, RepoStatsFailedState] on no results',
        () async {
      const response = FetchCountsResponse(
        filesCount: 0,
        totalLettersCount: {},
      );

      when(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).thenAnswer((_) async => const Right(response));

      final expectedStates = [
        const RepoStatsLoadingState(),
        const RepoStatsFailedState(NoResultsForLanguageFailure()),
      ];
      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.fetchStats(args);

      verify(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).called(1);
    });

    test('emits [RepoStatsLoadingState, RepoStatsFailedState] on failure',
        () async {
      const failure = GenericFailure('Test failure');

      when(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).thenAnswer((_) async => const Left(failure));

      final expectedStates = [
        const RepoStatsLoadingState(),
        const RepoStatsFailedState(failure),
      ];
      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.fetchStats(args);

      verify(() => mockRepository.fetchLettersCount(
            repoName: args.repoName,
            repoOwner: args.repoOwner,
            branch: args.branch,
            languages: args.languages,
          )).called(1);
    });
  });
}
