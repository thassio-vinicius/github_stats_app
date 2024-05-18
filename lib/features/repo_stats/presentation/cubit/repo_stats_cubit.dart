import 'package:flutter/foundation.dart';
import 'package:github_stats_app/core/errors/failures.dart';
import 'package:github_stats_app/core/utils/base_cubit.dart';
import 'package:github_stats_app/features/repo_stats/domain/repository/repo_stats_repository.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_state.dart';
import 'package:github_stats_app/features/repo_stats/presentation/repo_stats_screen.dart';

class RepoStatsCubit extends BaseCubit<RepoStatsState> {
  RepoStatsCubit(this._repository) : super(const RepoStatsInitialState());

  final RepoStatsRepository _repository;

  Future<void> fetchStats(RepoStatsArgs args) async {
    emit(const RepoStatsLoadingState());

    final response = await _repository.fetchLettersCount(
      repoName: args.repoName,
      repoOwner: args.repoOwner,
      languages: args.languages,
      branch: args.branch,
    );

    response.fold(
      (l) {
        debugPrint(l.toString());
        emit(RepoStatsFailedState(l));
      },
      (r) {
        if (r.isEmpty) {
          emit(const RepoStatsFailedState(NoResultsForLanguageFailure()));
          return;
        }

        emit(
          RepoStatsLoadedState(totalLettersCount: r),
        );
      },
    );
  }
}
