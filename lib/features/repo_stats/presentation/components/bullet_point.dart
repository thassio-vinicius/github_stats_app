import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText('  • '),
        Expanded(
          child: MyText.small(
            text,
            style: MyTextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
