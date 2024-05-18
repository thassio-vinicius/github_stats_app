import 'package:flutter/material.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/widgets/app_logo.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/utils/colors.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class AnimatedLogoStack extends StatelessWidget {
  final Animation<double>? animation;
  const AnimatedLogoStack({this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      double circleSize = (animation?.value ?? 1) *
          (screenWidth > screenHeight ? screenWidth : screenHeight) *
          2;
      double adjustedSize =
          circleSize >= screenWidth * 0.4 ? circleSize : screenWidth * 0.4;

      double leftOffset = (screenWidth - adjustedSize) / 2;
      double topOffset =
          ((screenHeight - adjustedSize) / 2) - screenHeight * 0.2;

      double opacityValue = animation?.value ?? 1;
      if (opacityValue < 0.0) opacityValue = 0.0;
      if (opacityValue > 1.0) opacityValue = 1.0;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: leftOffset,
            top: topOffset,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              constraints: const BoxConstraints(minWidth: 100),
              width: adjustedSize,
              height: adjustedSize,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenWidth * 0.2, child: const AppLogo()),
                        const SizedBox(width: 12)
                      ],
                    ),
                    Positioned(
                      top: screenHeight * 0.12,
                      child: AnimatedOpacity(
                        opacity: opacityValue,
                        duration: const Duration(milliseconds: 400),
                        child: SizedBox(
                          width: screenWidth * 0.6,
                          child: MyText.medium(
                            intl.appName,
                            style: MyTextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
