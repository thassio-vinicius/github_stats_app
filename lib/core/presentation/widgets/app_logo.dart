import 'package:flutter/material.dart';
import 'package:github_stats_app/core/utils/icons.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          AssetIcons.github,
          width: 75,
          height: 75,
          fit: BoxFit.scaleDown,
          color: Colors.white,
        ),
        Positioned(
          bottom: -2,
          right: -12,
          child: Image.asset(
            AssetIcons.statistics,
            width: 32,
            height: 32,
            fit: BoxFit.scaleDown,
            color: Colors.white,
          ),
        ),
        /*
        Positioned(
          bottom: 0,
          right: -12,
          child: Icon(
            Icons.bar_chart,
            color: Colors.black,
            size: 36,
          ),
        ),
         */
      ],
    );
  }
}
