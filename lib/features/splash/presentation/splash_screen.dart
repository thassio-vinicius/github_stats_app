import 'package:flutter/material.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/routes/my_navigator.dart';
import 'package:github_stats_app/core/presentation/routes/route_names.dart';
import 'package:github_stats_app/core/presentation/widgets/primary_button.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;
    return Scaffold(
      body: Center(
        child: PrimaryButton(
            text: intl.getStarted,
            onPressed: () =>
                MyNavigator(context).goNamed(RouteNames.repoStats)),
      ),
    );
  }
}
