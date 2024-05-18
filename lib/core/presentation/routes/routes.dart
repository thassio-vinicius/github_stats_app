import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/routes/route_names.dart';
import 'package:github_stats_app/features/repo_stats/presentation/repo_stats_form_screen.dart';
import 'package:github_stats_app/features/repo_stats/presentation/repo_stats_results_screen.dart';
import 'package:github_stats_app/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.splash,
  observers: [],
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SplashScreen(),
          name: state.name,
        );
      },
    ),
    GoRoute(
      name: RouteNames.repoForm,
      path: RouteNames.repoForm,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const RepoStatsFormScreen(),
          name: state.name,
        );
      },
    ),
    GoRoute(
      name: RouteNames.repoStatsResults,
      path: RouteNames.repoStatsResults,
      pageBuilder: (context, state) {
        final args = state.extra as RepoStatsArgs?;
        assert(args != null);
        return MaterialPage(
          child: RepoStatsResultsScreen(args: args!),
          name: state.name,
        );
      },
    ),
  ],
);
