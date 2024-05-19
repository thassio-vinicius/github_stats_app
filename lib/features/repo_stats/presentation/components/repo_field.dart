import 'package:flutter/material.dart';
import 'package:github_stats_app/core/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RepoField extends StatelessWidget {
  final Function() onSubmit;
  final String hint;
  final TextInputAction action;
  final TextEditingController controller;
  const RepoField({
    super.key,
    this.action = TextInputAction.next,
    required this.hint,
    required this.onSubmit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
      textInputAction: action,
      maxLines: null,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
