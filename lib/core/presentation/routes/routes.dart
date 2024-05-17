import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/routes/route_names.dart';
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
  ],
);
