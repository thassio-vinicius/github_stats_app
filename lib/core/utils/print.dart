import 'package:flutter/material.dart';

class Print {
  // COLORED TEXT WITH NO BACKGROUND
  static void black(var message) {
    debugPrint("\x1b[30m$message\x1B[0m");
  }

  static void red(var message) {
    debugPrint("\x1b[31m$message\x1B[0m");
  }

  static void green(var message) {
    debugPrint("\x1B[32m$message\x1B[0m");
  }

  static void yellow(var message) {
    debugPrint("\x1b[33m$message\x1B[0m");
  }

  static void blue(var message) {
    debugPrint("\x1b[34m$message\x1B[0m");
  }

  static void magenta(var message) {
    debugPrint("\x1b[35m$message\x1B[0m");
  }

  static void cyan(var message) {
    debugPrint("\x1b[36m$message\x1B[0m");
  }

  static void white(var message) {
    debugPrint("\x1b[37m$message\x1B[0m");
  }

  // COLORED BACKGROUND WITH DEFAULT TEXT COLOR
  static void blackBG(var message) {
    debugPrint("\x1B[40m$message\x1B[0m");
  }

  static void redBG(var message) {
    debugPrint("\x1B[41m$message\x1B[0m");
  }

  static void greenBG(var message) {
    debugPrint("\x1B[42m$message\x1B[0m");
  }

  static void yellowBG(var message) {
    debugPrint("\x1B[43m$message\x1B[0m");
  }

  static void blueBG(var message) {
    debugPrint("\x1B[44m$message\x1B[0m");
  }

  static void magentaBG(var message) {
    debugPrint("\x1B[45m$message\x1B[0m");
  }

  static void cyanBG(var message) {
    debugPrint("\x1B[46m$message\x1B[0m");
  }

  static void whiteBG(var message) {
    debugPrint("\x1B[47m$message\x1B[0m");
  }
}
