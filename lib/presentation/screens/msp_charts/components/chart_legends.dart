import 'package:flutter/material.dart';

class ChartLegends extends StatelessWidget {
  final Map<String, Color> legends;
  const ChartLegends({super.key, required this.legends});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: legends.entries.map((entry) {
          return Row(
            children: [
              Container(
                width: 14,
                height: 14,
                color: entry.value,
              ),
              const SizedBox(width: 4),
              Text(
                entry.key,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
