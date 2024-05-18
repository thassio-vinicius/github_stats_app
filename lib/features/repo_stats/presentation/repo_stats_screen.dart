import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stats_app/core/errors/failures.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/routes/my_navigator.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/presentation/widgets/primary_button.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_cubit.dart';
import 'package:github_stats_app/features/repo_stats/presentation/cubit/repo_stats_state.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class RepoStatsArgs {
  final String repoName;
  final String repoOwner;
  final String branch;
  final List<ProgrammingLanguage> languages;

  const RepoStatsArgs({
    required this.repoName,
    required this.branch,
    required this.repoOwner,
    required this.languages,
  });
}

class RepoStatsScreen extends StatefulWidget {
  final RepoStatsArgs args;
  const RepoStatsScreen({required this.args, super.key});

  @override
  State<RepoStatsScreen> createState() => _RepoStatsScreenState();
}

class _RepoStatsScreenState extends State<RepoStatsScreen> {
  List<Widget> _displayDecreasingLettersCount(RepoStatsLoadedState state) {
    final entries = state.totalLettersCount.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));

    return entries
        .map((e) => Center(
                child: MyText(
              '${e.key}: ${e.value}',
              style: MyTextStyle(color: Colors.black),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return BlocProvider(
      create: (_) => RepoStatsCubit(sl())..fetchStats(widget.args),
      child: Scaffold(
        body: BlocConsumer<RepoStatsCubit, RepoStatsState>(
          listener: (context, state) {},
          builder: (context, state) {
            bool isLoading = state is RepoStatsLoadingState;
            bool isLoaded = state is RepoStatsLoadedState;
            bool isFailed = state is RepoStatsFailedState;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (isLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _displayDecreasingLettersCount(state),
              );
            }

            if (isFailed) {
              String errorMessage = intl.genericError;
              if (state.failure is NoRepositoriesFailure) {
                errorMessage = intl.noRepositoriesFound;
              } else if (state.failure is NoResultsForLanguageFailure) {
                errorMessage =
                    intl.noResultsFound(widget.args.languages.first.key);
              }

              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: MyText.mediumSmall(
                        errorMessage,
                        style: MyTextStyle(
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.35),
                      child: PrimaryButton(
                        text: intl.tryAgain,
                        radius: 100,
                        onPressed: () => MyNavigator(context).pop(),
                      ),
                    )
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
