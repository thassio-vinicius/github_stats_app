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

/*
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class ListedView extends StatelessWidget {
  final Map<String, int> totalLettersCount;

  const ListedView({super.key, required this.totalLettersCount});

  Widget _listedItem(MapEntry<String, int> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            item.key,
            style: MyTextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          MyText(
            item.value.toString(),
            style: MyTextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: AppColors.greyBackground,
          ),
          child: ListView(
            children: totalLettersCount.entries.mapIndexed((index, child) {
              if (index == totalLettersCount.length - 1) {
                return _listedItem(child);
              } else {
                return Column(
                  children: [
                    _listedItem(child),
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Container(
                        color: Colors.grey,
                        width: MediaQuery.sizeOf(context).width,
                        height: 0.5,
                      ),
                    ),
                  ],
                );
              }
            }).toList(),
          ),
        ),
      ),
    );
  }
}

 */
