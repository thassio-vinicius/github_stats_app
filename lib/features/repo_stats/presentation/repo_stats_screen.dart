import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_cubit.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_state.dart';

class RepoStatsScreen extends StatefulWidget {
  const RepoStatsScreen({super.key});

  @override
  State<RepoStatsScreen> createState() => _RepoStatsScreenState();
}

class _RepoStatsScreenState extends State<RepoStatsScreen> {
  List<Widget> _displayDecreasingLettersCount(RepoStatsLoadedState state) {
    final entries = state.totalLettersCount.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));

    return entries
        .map((e) => Center(child: MyText('${e.key}: ${e.value}')))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepoStatsCubit(sl())..fetchStats(),
      child: Scaffold(
        body: BlocConsumer<RepoStatsCubit, RepoStatsState>(
          listener: (context, state) {},
          builder: (context, state) {
            bool isLoading = state is RepoStatsLoadingState;
            bool isLoaded = state is RepoStatsLoadedState;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (isLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _displayDecreasingLettersCount(state),
              );
            }

            return const Center(child: MyText('error'));
          },
        ),
      ),
    );
  }
}
