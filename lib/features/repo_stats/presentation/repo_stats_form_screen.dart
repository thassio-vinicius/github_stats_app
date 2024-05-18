import 'package:flutter/material.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/routes/my_navigator.dart';
import 'package:github_stats_app/core/presentation/routes/route_names.dart';
import 'package:github_stats_app/core/presentation/widgets/colored_safearea.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/presentation/widgets/primary_button.dart';
import 'package:github_stats_app/core/utils/colors.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
import 'package:github_stats_app/features/repo_stats/presentation/components/bullet_point.dart';
import 'package:github_stats_app/features/repo_stats/presentation/components/language_dropdown.dart';
import 'package:github_stats_app/features/repo_stats/presentation/components/repo_field.dart';
import 'package:github_stats_app/features/repo_stats/presentation/components/wave_container.dart';
import 'package:github_stats_app/features/repo_stats/presentation/repo_stats_results_screen.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class RepoStatsFormScreen extends StatefulWidget {
  const RepoStatsFormScreen({super.key});

  @override
  State<RepoStatsFormScreen> createState() => _RepoStatsFormScreenState();
}

class _RepoStatsFormScreenState extends State<RepoStatsFormScreen> {
  late final TextEditingController _nameController =
          TextEditingController(text: 'lodash'),
      _ownerController = TextEditingController(text: 'lodash'),
      _branchController = TextEditingController(text: 'main');
  ProgrammingLanguage? _firstLanguage = ProgrammingLanguage.javascript;
  ProgrammingLanguage? _secondLanguage = ProgrammingLanguage.typescript;

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;
    bool isButtonEnabled = _ownerController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _firstLanguage != null;
    return ColoredSafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: ListView(
              children: [
                WaveContainer(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      MyText.medium(
                        intl.statsFormTitle,
                        style: MyTextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      MyText.mediumSmall(
                        intl.howItWorks,
                        style: MyTextStyle(fontWeight: FontWeight.w500),
                      ),
                      BulletPoint(intl.howItWorksStep1),
                      BulletPoint(intl.howItWorksStep2),
                      BulletPoint(intl.howItWorksStep3),
                      BulletPoint(intl.howItWorksStep4),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      RepoField(
                        hint: intl.ownerHint,
                        onSubmit: () => FocusScope.of(context).nextFocus(),
                        action: TextInputAction.next,
                        controller: _ownerController,
                      ),
                      const SizedBox(height: 16),
                      RepoField(
                        hint: intl.nameHint,
                        onSubmit: () => FocusScope.of(context).nextFocus(),
                        controller: _nameController,
                        action: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      RepoField(
                        hint: intl.branchHint,
                        onSubmit: () => FocusScope.of(context).unfocus(),
                        controller: _branchController,
                        action: TextInputAction.done,
                      ),
                      const SizedBox(height: 16),
                      LanguageDropdown(
                          hint: intl.languageHint,
                          defaultValue: _firstLanguage,
                          onChanged: (language) {
                            setState(() {
                              _firstLanguage = language;
                            });
                          }),
                      const SizedBox(height: 16),
                      LanguageDropdown(
                          hint: intl.languageHint,
                          defaultValue: _secondLanguage,
                          onChanged: (language) {
                            setState(() {
                              _secondLanguage = language;
                            });
                          }),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: intl.seeStatistics,
                        onPressed: isButtonEnabled
                            ? () => MyNavigator(context).pushNamed(
                                  RouteNames.repoStatsResults,
                                  extra: RepoStatsArgs(
                                    repoName: _nameController.text,
                                    repoOwner: _ownerController.text,
                                    branch: _branchController.text,
                                    languages: [
                                      _firstLanguage!,
                                      if (_secondLanguage != null)
                                        _secondLanguage!,
                                    ],
                                  ),
                                )
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
