import 'package:chart_libraries_tests/helpers/human_formats.dart';
import 'package:chart_libraries_tests/presentation/screens/msp_charts/components/segmented_button.dart';
import 'package:chart_libraries_tests/presentation/screens/msp_charts/components/chart_label.dart';
import 'package:chart_libraries_tests/presentation/screens/msp_charts/components/chart_legends.dart';
import 'package:chart_libraries_tests/presentation/screens/msp_charts/data.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'dart:ui';

class LinearChartScreen extends StatefulWidget {
  const LinearChartScreen({super.key});

  @override
  State<LinearChartScreen> createState() => _LinearChartScreenState();
}

enum Calendar { week, month, year }

class _LinearChartScreenState extends State<LinearChartScreen> {
  Calendar calendarView = Calendar.week;

  void _onCalendarChanged(Calendar newCalendar) {
    setState(() {
      calendarView = newCalendar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Utilidades",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              _LinealChartView(
                  calendarView: calendarView,
                  onCalendarChanged: _onCalendarChanged),
            ],
          )),
    );
  }
}

class _LinealChartView extends StatelessWidget {
  final Calendar calendarView;
  final ValueChanged<Calendar> onCalendarChanged;
  const _LinealChartView(
      {required this.calendarView, required this.onCalendarChanged});

  @override
  Widget build(BuildContext context) {
    const color1 = Color(0xFFFF8623);
    const color2 = Color(0xff202427);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.black12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ChartLabel(
            label: "1 Agosto 2024 | 11:00 hrs",
          ),
          const ChartLegends(legends: {
            'Actual': color1,
            'Anterior': color2,
          }),
          LinealChart(
            calendarView: calendarView,
            colors: const [color1, color2],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 48),
            child: CalendarSegmentedButton(
              selectedCalendar: calendarView,
              onSelectionChanged: onCalendarChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class LinealChart extends StatelessWidget {
  final Calendar calendarView;
  final List<Color> colors;

  const LinealChart(
      {super.key, required this.calendarView, required this.colors});

  @override
  Widget build(BuildContext context) {
    // todo considerar espacios en blanco

    List<Map<String, dynamic>> getDataForCalendarView() {
      switch (calendarView) {
        case Calendar.week:
          return dataPerWeek;
        case Calendar.month:
          return dataPerMonth;
        case Calendar.year:
          return dataPerYear;
        default:
          return [];
      }
    }

    final data = getDataForCalendarView();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 230,
      child: Chart(
        rebuild: true,
        data: data,
        variables: {
          'day': Variable(
            accessor: (Map datum) => datum['day'] as String,
            scale: OrdinalScale(inflate: true),
          ),
          'value': Variable(
            accessor: (Map datum) => datum['value'] as num,
            scale: LinearScale(
              niceRange: true,
              min: 0,
              formatter: (v) => HumanFormats.humanReadableNumber(v.toDouble()),
            ),
          ),
          'group': Variable(
            accessor: (Map datum) => datum['group'] as String,
          ),
        },
        marks: [
          LineMark(
            position: Varset('day') * Varset('value') / Varset('group'),
            color: ColorEncode(
              variable: 'group',
              values: colors,
            ),
            size: SizeEncode(
              value: 2,
            ),
          ),
          PointMark(
            position: Varset('day') * Varset('value') / Varset('group'),
            color: ColorEncode(
              variable: 'group',
              values: colors,
            ),
            shape: ShapeEncode(
              value: CircleShape(hollow: false, strokeWidth: 2),
            ),
            size: SizeEncode(
              value: 9,
            ),
          ),
          PointMark(
            position: Varset('day') * Varset('value') / Varset('group'),
            color: ColorEncode(
              variable: 'group',
              values: [
                Colors.white,
                Colors.white,
              ],
            ),
            shape: ShapeEncode(
              value: CircleShape(hollow: false, strokeWidth: 2),
            ),
            size: SizeEncode(
              value: 5,
            ),
          ),
        ],
        axes: [
          AxisGuide(
            dim: Dim.x,
            label: LabelStyle(
              span: (String label) {
                final trimmedLabel =
                    label.length > 3 ? label.substring(0, 3) : label;
                return TextSpan(
                  text: trimmedLabel,
                  style: const TextStyle(color: Colors.black45, fontSize: 10),
                );
              },
            ),
          ),
          Defaults.verticalAxis,
        ],
        selections: {
          'tooltipMouse': PointSelection(on: {
            GestureType.hover,
          }, devices: {
            PointerDeviceKind.mouse
          }, variable: 'day', dim: Dim.x),
          'tooltipTouch': PointSelection(on: {
            GestureType.scaleUpdate,
            GestureType.tapDown,
            GestureType.longPressMoveUpdate
          }, devices: {
            PointerDeviceKind.touch
          }, variable: 'day', dim: Dim.x),
        },
        tooltip: TooltipGuide(
          followPointer: [false, true],
          offset: const Offset(-5, -15),
          align: Alignment.topLeft,
          variables: [
            'group',
            'value',
          ],
          //!  Custom tooltip
          // renderer: (size, anchor, selectedTuples) {
          //   final line1 = selectedTuples.values.first;
          //   final line2 = selectedTuples.values.last;
          //   final Offset offset = Offset(anchor.dx - 25, anchor.dy - 30);
          //   final elements = <MarkElement>[
          //     GroupElement(
          //       elements: [
          //         RectElement(
          //           borderRadius: BorderRadius.circular(4),
          //           style: PaintStyle(
          //             fillColor: Colors.grey.shade300,
          //           ),
          //           rect: Rect.fromCenter(
          //               center: offset, width: 90, height: 55),
          //         ),
          //         LabelElement(
          //           text:
          //               "${selectedTuples.values.first["day"]}", // Texto de ejemplo usando el día
          //           anchor: Offset(offset.dx, offset.dy - 14),
          //           style: LabelStyle(
          //             textStyle: TextStyle(color: color1, fontSize: 14),
          //           ),
          //         ),
          //         LabelElement(
          //           defaultAlign: Alignment.centerLeft,
          //           text: "${line1["group"]}: \$${line1["value"]}",
          //           anchor: Offset(offset.dx, offset.dy + 5),
          //           style: LabelStyle(
          //               textStyle: TextStyle(color: color2, fontSize: 11),
          //               textAlign: TextAlign.start),
          //         ),
          //         LabelElement(
          //           defaultAlign: Alignment.centerLeft,
          //           text: "${line2["group"]}: \$${line2["value"]}",
          //           anchor: Offset(offset.dx, offset.dy + 20),
          //           style: LabelStyle(
          //               textStyle: TextStyle(color: color2, fontSize: 11),
          //               textAlign: TextAlign.start),
          //         ),
          //       ],
          //     )
          //   ];
          //   return elements;
          // }),
        ),
        crosshair: CrosshairGuide(
          followPointer: [false, true],
        ),
        coord: RectCoord(
          horizontalRange: [0.02, 0.98],
          verticalRange: [0.02, 1],
          // !activar el zoom
          // horizontalRangeUpdater: Defaults
          //     .horizontalRangeEvent, // Evento para actualizar el rango horizontal
          // verticalRangeUpdater: Defaults
          //     .verticalRangeEvent, // Evento para actualizar el rango vertical
        ),
      ),
    );
  }
}
