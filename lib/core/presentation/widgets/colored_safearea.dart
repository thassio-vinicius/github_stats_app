import 'package:flutter/material.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool bottom;
  const ColoredSafeArea({
    super.key,
    required this.child,
    this.color,
    this.bottom = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: bottom,
        child: child,
      ),
    );
  }
}
