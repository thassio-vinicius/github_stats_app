import 'package:flutter/material.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class CustomToggle extends StatelessWidget {
  final List<bool> selected;
  final Function(int) onSelect;
  const CustomToggle({
    super.key,
    required this.onSelect,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: selected,
      onPressed: onSelect,
      borderRadius: BorderRadius.circular(10),
      selectedColor: AppColors.primary,
      fillColor: Colors.white,
      color: Colors.grey,
      constraints: const BoxConstraints(minHeight: 40.0, minWidth: 100.0),
      children: const <Widget>[
        Icon(Icons.list),
        Icon(Icons.bar_chart),
        Icon(Icons.stacked_line_chart),
      ],
    );
  }
}
