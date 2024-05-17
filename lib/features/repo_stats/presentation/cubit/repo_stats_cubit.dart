import 'package:github_stats_app/core/utils/base_cubit.dart';
import 'package:github_stats_app/features/repo_stats/domain/repository/repo_stats_repository.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_state.dart';

class RepoStatsCubit extends BaseCubit<RepoStatsState> {
  RepoStatsCubit(this._repository) : super(const RepoStatsInitialState());

  final RepoStatsRepository _repository;

  Future<void> fetchStats() async {
    emit(const RepoStatsLoadingState());

    const repo = 'lodash';

    final response = await _repository.fetchLettersCount(repo, repo);

    response.fold(
      (l) {
        print(l.toString());
        emit(const RepoStatsFailedState());
      },
      (r) {
        emit(
          RepoStatsLoadedState(totalLettersCount: r),
        );
      },
    );
  }
}
