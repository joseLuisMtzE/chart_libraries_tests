import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CircularCustomScreen extends StatelessWidget {
  const CircularCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Lineal chart"),
      ),
      body: const Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _ChartView(),
              _Legends(),
            ],
          )
        ],
      )),
    );
  }
}

class _Legends extends StatelessWidget {
  const _Legends({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.orange.shade500,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("Series 1"),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("Series 2"),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.redAccent.shade700,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("Series 3"),
          ],
        )
      ],
    );
  }
}

class _ChartView extends StatelessWidget {
  const _ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 10),
      child: SizedBox(
          height: 250,
          width: 250,
          child: PieChart(PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 1,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ))),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      // final isTouched = i == touchedIndex;
      // final fontSize = isTouched ? 25.0 : 16.0;
      final fontSize = 16.0;
      final radius = 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.orange.shade500,
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.deepOrange,
            value: 45,
            title: '45%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.redAccent.shade700,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
