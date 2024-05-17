import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontSize {
  extraSmall(10),
  small(12),
  normal(14),
  mediumSmall(16),
  medium(21),
  large(25),
  xLarge(30),
  xxLarge(70),
  xxxLarge(80);

  final double size;

  const FontSize(this.size);
}

class MyTextStyle {
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final List<Shadow>? shadows;

  MyTextStyle({
    this.fontWeight,
    this.color,
    this.textAlign,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.fontStyle,
    this.shadows,
    this.letterSpacing,
  });
}

class MyText extends StatelessWidget {
  final String text;
  final MyTextStyle? style;
  final FontSize fontSize;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.fontSize = FontSize.normal,
  });

  const MyText.extraSmall(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.extraSmall;

  const MyText.small(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.small;

  const MyText.normal(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.normal;

  const MyText.mediumSmall(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.mediumSmall;

  const MyText.medium(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.medium;

  const MyText.large(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.large;

  const MyText.xLarge(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.xLarge;

  const MyText.xxLarge(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.xxLarge;

  const MyText.xxxLarge(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : fontSize = FontSize.xxxLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: fontSize.size,
        color: style?.color ?? Colors.white,
        fontWeight: style?.fontWeight,
        decorationColor: style?.decorationColor,
        decorationStyle: style?.decorationStyle,
        decoration: style?.decoration,
        fontStyle: style?.fontStyle,
        letterSpacing: style?.letterSpacing,
        shadows: style?.shadows,
      ),
      textAlign: style?.textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
