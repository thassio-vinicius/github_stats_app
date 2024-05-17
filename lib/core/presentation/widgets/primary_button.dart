import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.trailingIcon,
    this.backgroundColor,
    this.textColor,
    this.radius = 16,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? AppColors.primary;
    final borderRadius = BorderRadius.circular(radius);
    const padding = EdgeInsets.all(16);
    const height = 56.0;
    final isEnabled = onPressed != null && !isLoading;

    final child = Container(
      height: height,
      width: double.infinity,
      padding: padding,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(trailingIcon),
                ),
                Center(
                  child: MyText(
                    text.toUpperCase(),
                    style: MyTextStyle(
                      color: textColor ?? Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );

    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isLoading ? null : onPressed,
            color: color,
            disabledColor: AppColors.primary.withOpacity(0.3),
            borderRadius: borderRadius,
            child: child,
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isEnabled ? color : AppColors.primary.withOpacity(0.3),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: child,
          );
  }
}
