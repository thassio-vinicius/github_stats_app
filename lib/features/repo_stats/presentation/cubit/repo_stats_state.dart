import 'package:equatable/equatable.dart';
import 'package:github_stats_app/core/errors/failure.dart';

abstract class RepoStatsState extends Equatable {
  const RepoStatsState();

  @override
  List<Object?> get props => [];
}

class RepoStatsInitialState extends RepoStatsState {
  const RepoStatsInitialState();
}

class RepoStatsLoadedState extends RepoStatsState {
  const RepoStatsLoadedState({required this.totalLettersCount});

  final Map<String, int> totalLettersCount;
}

class RepoStatsLoadingState extends RepoStatsState {
  const RepoStatsLoadingState();
}

class RepoStatsFailedState extends RepoStatsState {
  final Failure failure;
  const RepoStatsFailedState(this.failure);
}
