import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/utils/colors.dart';
import 'package:github_stats_app/core/utils/programming_language_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageDropdown extends StatelessWidget {
  final Function(ProgrammingLanguage?) onChanged;
  final ProgrammingLanguage? defaultValue;
  final String hint;
  const LanguageDropdown({
    super.key,
    this.defaultValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProgrammingLanguage>(
      style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
      items: ProgrammingLanguage.values
          .map(
            (e) => DropdownMenuItem<ProgrammingLanguage>(
              value: e,
              child: MyText.mediumSmall(
                e.key,
                style: MyTextStyle(color: Colors.black),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: defaultValue,
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
