import 'package:flutter/material.dart';

class ChartLabel extends StatelessWidget {
  final String label;
  const ChartLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.update_sharp,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
