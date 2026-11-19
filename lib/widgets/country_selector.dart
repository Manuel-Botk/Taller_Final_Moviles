import 'package:flutter/material.dart';

class CountrySelector extends StatelessWidget {
  final List<String> countries;
  final String selected;
  final ValueChanged<String> onChanged;

  const CountrySelector({
    super.key,
    required this.countries,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      isExpanded: true,
      items: countries
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}