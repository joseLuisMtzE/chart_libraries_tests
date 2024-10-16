import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:chart_libraries_tests/helpers/human_formats.dart';
import 'package:chart_libraries_tests/helpers/zoomable_widget.dart';

class FlChartsZoomScreen extends StatefulWidget {
  const FlChartsZoomScreen({super.key});

  // Colores personalizados para las barras de 2023 y 2024
  final Color year2023BarColor = Colors.black;
  final Color year2024BarColor = Colors.orange;

  @override
  State<StatefulWidget> createState() => _FlChartsZoomScreenState();
}

class _FlChartsZoomScreenState extends State<FlChartsZoomScreen> {
  final double width = 20;
  int touchedIndex = -1;

  late List<BarChartGroupData> barGroups;

  @override
  void initState() {
    super.initState();

    // Crear dos grupos de barras, uno para cada año
    final barGroup1 =
        makeGroupData(0, 7248.3, widget.year2023BarColor); // Datos para 2023
    final barGroup2 =
        makeGroupData(1, 6746.06, widget.year2024BarColor); // Datos para 2024
    barGroups = [barGroup1, barGroup2];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FL Charts Zoom'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Importe por Año',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    color: widget.year2023BarColor,
                    text: '2023',
                    isSquare: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    color: widget.year2024BarColor,
                    text: '2024',
                    isSquare: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ZoomableWidget(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: 8000,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBorder: const BorderSide(
                                color: Colors.blueGrey, width: 2),
                            tooltipRoundedRadius: 8,
                            tooltipPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            tooltipMargin: 16,
                            tooltipHorizontalAlignment:
                                FLHorizontalAlignment.center,
                            maxContentWidth: 120,
                            getTooltipColor: (group) =>
                                Colors.grey.withOpacity(0.8),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String year = group.x == 0 ? '2023' : '2024';
                              return BarTooltipItem(
                                '$year\n\$${rod.toY}',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            },
                          ),
                          touchCallback:
                              (FlTouchEvent event, barTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  barTouchResponse == null ||
                                  barTouchResponse.spot == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex =
                                  barTouchResponse.spot!.touchedBarGroupIndex;
                            });
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 42,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
                                String text;
                                int intValue = value.round(); //  valor a entero
                                if (intValue == 0) {
                                  text = HumanFormats.humanReadableNumber(
                                      7248.3); // Monto para 2023
                                } else if (intValue == 1) {
                                  text = HumanFormats.humanReadableNumber(
                                      6746.06); // Monto para 2024
                                } else {
                                  text = '';
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(text, style: style),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 2000,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                );
                                return Text('\$${value.toStringAsFixed(0)}',
                                    style: style);
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: barGroups,
                        gridData: const FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}

// Widget para las leyendas (indicadores)
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: isSquare ? 16 : 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
