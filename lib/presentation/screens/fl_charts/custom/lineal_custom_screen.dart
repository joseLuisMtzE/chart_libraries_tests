import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:chart_libraries_tests/helpers/zoomable_widget.dart';

class LinealCustomScreen extends StatelessWidget {
  const LinealCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Lineal chart"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            _Legends(),
            SizedBox(),
            _ChartView(),
          ],
        ),
      ),
    );
  }
}

class _Legends extends StatelessWidget {
  const _Legends({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: Colors.purple.shade400),
        ),
        const SizedBox(width: 4),
        const Text("Semana Actual"),
        const SizedBox(width: 16),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: Colors.teal.shade400),
        ),
        const SizedBox(width: 4),
        const Text("Semana anterior"),
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
      child: ZoomableWidget(
        minScale: 1.0,
        maxScale: 3.0,
        child: SizedBox(
          height: 500,
          width: MediaQuery.of(context).size.width - 20,
          child: LineChart(
            LineChartData(
              lineTouchData: lineTouchData,
              gridData: const FlGridData(show: false),
              titlesData: titlesData,
              borderData: borderData,
              lineBarsData: lineBarsData2,
              minX: 0,
              maxX: 100,
              maxY: 100,
              minY: 0,
            ),
          ),
        ),
      ),
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.grey.withOpacity(.05),
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 50,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 50,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          left: BorderSide(color: Colors.black, width: 1),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData1,
        lineChartBarData2,
      ];

  LineChartBarData get lineChartBarData1 {
    final Color lineColor = Colors.purple.shade400;
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: lineColor,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
          color: Colors.white,
          strokeColor: lineColor,
          strokeWidth: 2.0,
          radius: 4,
        ),
        show: true,
      ),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(0, 10),
        FlSpot(20, 20),
        FlSpot(40, 35),
        FlSpot(60, 60),
        FlSpot(80, 75),
        FlSpot(90, 95),
        FlSpot(100, 100),
      ],
    );
  }

  LineChartBarData get lineChartBarData2 {
    final Color lineColor = Colors.teal.shade400;
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: lineColor,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
          color: Colors.white,
          strokeColor: lineColor,
          strokeWidth: 2.0,
          radius: 4,
        ),
        show: true,
      ),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(0, 55),
        FlSpot(20, 5),
        FlSpot(40, 25),
        FlSpot(60, 55),
        FlSpot(80, 40),
        FlSpot(90, 10),
        FlSpot(100, 30),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, textAlign: TextAlign.end),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
