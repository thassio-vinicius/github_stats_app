import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatefulWidget {
  final bool large;
  final bool animate;
  const AppLogo({
    super.key,
    required this.large,
    required this.animate,
  });

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  final _duration = const Duration(milliseconds: 150);

  late final List<double> _opacities =
      List.generate(_logoLength(), (index) => widget.animate ? 0 : 1);

  final _firstHalf = 'rank';
  final _secondHalf = 'AI';

  int _logoLength() {
    return _firstHalf.length + _secondHalf.length;
  }

  Widget _fadeText(int index, double opacity, bool isFirstHalf) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: _duration,
      child: Text(
        isFirstHalf
            ? _firstHalf[index]
            : _secondHalf[index - _firstHalf.length],
        style: isFirstHalf
            ? GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: widget.large ? 60 : 40,
              )
            : GoogleFonts.poppins(
                color: Colors.white,
                fontSize: widget.large ? 40 : 26,
              ),
      ),
    );
  }

  @override
  void initState() {
    Timer(kThemeAnimationDuration, () {
      for (int i = 0; i < _opacities.length; i++) {
        Timer(_duration * (i + 1), () {
          setState(() {
            _opacities[i] = 1;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: List.generate(
        _logoLength(),
        (index) => _fadeText(
          index,
          _opacities[index],
          index < _firstHalf.length,
        ),
      ),
    );
  }
}
