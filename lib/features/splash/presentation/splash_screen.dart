import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/routes/my_navigator.dart';
import 'package:github_stats_app/core/presentation/routes/route_names.dart';
import 'package:github_stats_app/core/presentation/widgets/primary_button.dart';
import 'package:github_stats_app/core/utils/colors.dart';
import 'package:github_stats_app/features/splash/presentation/components/animated_logo_stack.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Cubic(0.33, -0.22, 1, 0.23),
      ),
    );

    Timer(const Duration(milliseconds: 800), () {
      _animationController.forward();
    });

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        setState(() {
          _opacity = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return AnimatedLogoStack(animation: _animation);
              },
            ),
            Positioned(
              bottom: 32,
              left: 24,
              right: 24,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 750),
                opacity: _opacity,
                child: PrimaryButton(
                    backgroundColor: Colors.white,
                    textColor: AppColors.primary,
                    text: intl.getStarted,
                    onPressed: () =>
                        MyNavigator(context).goNamed(RouteNames.repoForm)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
