import 'dart:ui';

import 'package:chart_libraries_tests/helpers/human_formats.dart';
import 'package:chart_libraries_tests/presentation/screens/msp_charts/components/SegmentedButton.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class MspChartsScreen extends StatefulWidget {
  const MspChartsScreen({super.key});

  @override
  State<MspChartsScreen> createState() => _MspChartsScreenState();
}

enum Calendar { week, month, year }

class _MspChartsScreenState extends State<MspChartsScreen> {
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
        title: const Text('Microsip Charts'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Utilidades",
                style: TextStyle(fontSize: 16),
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.black12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _LabelTextChart(
            label: "1 Agosto 2024 | 11:00 hrs",
          ),
          LinealChart(
            calendarView: calendarView,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
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

class _LabelTextChart extends StatelessWidget {
  final String label;
  const _LabelTextChart({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.update_sharp),
          )
        ],
      ),
    );
  }
}

class LinealChart extends StatelessWidget {
  final Calendar calendarView;

  const LinealChart({super.key, required this.calendarView});

  final color1 = const Color(0xFFFF8623);
  final color2 = const Color(0xff202427);

  @override
  Widget build(BuildContext context) {
    // todo considerar espacios en blanco

    List<Map<String, dynamic>> _getDataForCalendarView() {
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

    final data = _getDataForCalendarView();

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

              // tickCount: ,
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
              values: [
                color1,
                color2,
              ],
            ),
            size: SizeEncode(
              value: 2,
            ),
          ),
          PointMark(
            position: Varset('day') * Varset('value') / Varset('group'),
            color: ColorEncode(
              variable: 'group',
              values: [
                color1,
                color2,
              ],
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
              // Usa la función span para recortar las etiquetas
              span: (String label) {
                final trimmedLabel =
                    label.length > 3 ? label.substring(0, 3) : label;
                return TextSpan(
                  text: trimmedLabel,
                  style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 10), // Aplica estilo aquí
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
          verticalRange: [0, 1],
          // horizontalRangeUpdater: Defaults
          //     .horizontalRangeEvent, // Evento para actualizar el rango horizontal
          // verticalRangeUpdater: Defaults
          //     .verticalRangeEvent, // Evento para actualizar el rango vertical
        ),
      ),
    );
  }
}

const dataPerWeek = [
  {'day': 'Lunes', 'value': 1000, 'group': 'Actual'},
  {'day': 'Martes', 'value': 2000, 'group': 'Actual'},
  {'day': 'Miercoles', 'value': 3500, 'group': 'Actual'},
  {'day': 'Jueves', 'value': 6000, 'group': 'Actual'},
  {'day': 'Viernes', 'value': 7500, 'group': 'Actual'},
  // {'day': 'Sabado', 'value': 9500, 'group': 'Actual'},
  // {'day': 'Domingo', 'value': 10000, 'group': 'Actual'},
  // {'day': 'Lunes', 'value': 5500, 'group': 'Anterior'},
  // {'day': 'Martes', 'value': 500, 'group': 'Anterior'},
  // {'day': 'Miercoles', 'value': 2500, 'group': 'Anterior'},
  // {'day': 'Jueves', 'value': 5500, 'group': 'Anterior'},
  // {'day': 'Viernes', 'value': 4000, 'group': 'Anterior'},
  // {'day': 'Sabado', 'value': 1000, 'group': 'Anterior'},
  // {'day': 'Domingo', 'value': 3000, 'group': 'Anterior'},
];
const dataPerMonth = [
  {'day': 'S1', 'value': 10, 'group': 'Mes actual'},
  {'day': 'S2', 'value': 20, 'group': 'Mes actual'},
  {'day': 'S3', 'value': 35, 'group': 'Mes actual'},
  {'day': 'S4', 'value': 60, 'group': 'Mes actual'},
  {'day': 'S1', 'value': 55, 'group': 'Mes anterior'},
  {'day': 'S2', 'value': 5, 'group': 'Mes anterior'},
  {'day': 'S3', 'value': 25, 'group': 'Mes anterior'},
  {'day': 'S4', 'value': 55, 'group': 'Mes anterior'},
];
const dataPerYear = [
  {'day': 'Enero', 'value': 10, 'group': 'Año actual'},
  {'day': 'Febrero', 'value': 20, 'group': 'Año actual'},
  {'day': 'Marzo', 'value': 35, 'group': 'Año actual'},
  {'day': 'Abril', 'value': 15, 'group': 'Año actual'},
  {'day': 'Mayo', 'value': 25, 'group': 'Año actual'},
  {'day': 'Junio', 'value': 28, 'group': 'Año actual'},
  {'day': 'Julio', 'value': 8, 'group': 'Año actual'},
  {'day': 'Agosto', 'value': 7, 'group': 'Año actual'},
  {'day': 'Septiembre', 'value': 16, 'group': 'Año actual'},
  {'day': 'Octubre', 'value': 24, 'group': 'Año actual'},
  {'day': 'Noviembre', 'value': 40, 'group': 'Año actual'},
  {'day': 'Diciembre', 'value': 42, 'group': 'Año actual'},
  //? otro anio
  {'day': 'Enero', 'value': 28, 'group': 'Año anterior'},
  {'day': 'Febrero', 'value': 11, 'group': 'Año anterior'},
  {'day': 'Marzo', 'value': 35, 'group': 'Año anterior'},
  {'day': 'Abril', 'value': 66, 'group': 'Año anterior'},
  {'day': 'Mayo', 'value': 0, 'group': 'Año anterior'},
  {'day': 'Junio', 'value': 60, 'group': 'Año anterior'},
  {'day': 'Julio', 'value': 71, 'group': 'Año anterior'},
  {'day': 'Agosto', 'value': 45, 'group': 'Año anterior'},
  {'day': 'Septiembre', 'value': 60, 'group': 'Año anterior'},
  {'day': 'Octubre', 'value': 39, 'group': 'Año anterior'},
  {'day': 'Noviembre', 'value': 22, 'group': 'Año anterior'},
  {'day': 'Diciembre', 'value': 10, 'group': 'Año anterior'},
];
