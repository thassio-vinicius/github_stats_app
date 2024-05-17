import 'package:get_it/get_it.dart';
import 'package:github_stats_app/core/http/client.dart';
import 'package:github_stats_app/features/repo_stats/data/data_source/repo_stats_data_source.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<GlobalAppLocalizations>(GlobalAppLocalizationsImpl());

  sl.registerSingleton<HTTP>(HTTP());

  sl.registerFactory<RepoStatsDataSource>(
    () => RepoStatsDataSourceImpl(sl()),
  );
}
