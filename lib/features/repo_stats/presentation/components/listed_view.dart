import 'package:flutter/material.dart';
import 'package:github_stats_app/core/injector.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

class ListedView extends StatelessWidget {
  final Map<String, int> totalLettersCount;

  const ListedView({
    super.key,
    required this.totalLettersCount,
  });

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: DataTable(
        columnSpacing: MediaQuery.sizeOf(context).width * 0.6,
        columns: [
          DataColumn(
            label: MyText(
              intl.letter,
              style: MyTextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DataColumn(
            label: MyText(
              intl.count,
              style: MyTextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
        rows: totalLettersCount.entries
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    MyText(
                      e.key,
                      style: MyTextStyle(color: Colors.black),
                    ),
                  ),
                  DataCell(
                    MyText(
                      e.value.toString(),
                      style: MyTextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
