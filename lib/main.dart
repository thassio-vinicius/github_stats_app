import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stats_app/core/injector.dart' as di;
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/routes/routes.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await di.init();

  runApp(const RankAI());
}

class RankAI extends StatelessWidget {
  const RankAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        sl<GlobalAppLocalizations>().setAppLocalizations(
          AppLocalizations.of(context),
        );
        return child ?? Container();
      },
    );
  }
}
