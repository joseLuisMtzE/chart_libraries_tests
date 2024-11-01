import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import './echarts.dart';

class BarGraphicScreen extends StatelessWidget {
  const BarGraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Area group chart"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Area group chart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                height: 300,
                child: Chart(
                  data: areaStackGradientData,
                  variables: {
                    'day': Variable(
                      accessor: (Map datum) => datum['day'] as String,
                      scale: OrdinalScale(inflate: true),
                    ),
                    'value': Variable(
                      accessor: (Map datum) => datum['value'] as num,
                      scale: LinearScale(min: 0, max: 1500),
                    ),
                    'group': Variable(
                      accessor: (Map datum) => datum['group'].toString(),
                    ),
                  },
                  marks: [
                    AreaMark(
                      position:
                          Varset('day') * Varset('value') / Varset('group'),
                      shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                      gradient: GradientEncode(
                        variable: 'group',
                        values: [
                          const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(204, 128, 255, 165),
                              Color.fromARGB(204, 1, 191, 236),
                            ],
                          ),
                          const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(204, 0, 221, 255),
                              Color.fromARGB(204, 77, 119, 255),
                            ],
                          ),
                          const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(204, 55, 162, 255),
                              Color.fromARGB(204, 116, 21, 219),
                            ],
                          ),
                          const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(204, 255, 0, 135),
                              Color.fromARGB(204, 135, 0, 157),
                            ],
                          ),
                          const LinearGradient(
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(204, 255, 191, 0),
                              Color.fromARGB(204, 224, 62, 76),
                            ],
                          ),
                        ],
                        updaters: {
                          'groupMouse': {
                            false: (gradient) => LinearGradient(
                                  begin: const Alignment(0, 0),
                                  end: const Alignment(0, 1),
                                  colors: [
                                    gradient.colors.first.withAlpha(25),
                                    gradient.colors.last.withAlpha(25),
                                  ],
                                ),
                          },
                          'groupTouch': {
                            false: (gradient) => LinearGradient(
                                  begin: const Alignment(0, 0),
                                  end: const Alignment(0, 1),
                                  colors: [
                                    gradient.colors.first.withAlpha(25),
                                    gradient.colors.last.withAlpha(25),
                                  ],
                                ),
                          },
                        },
                      ),
                      modifiers: [StackModifier()],
                    ),
                  ],
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                  selections: {
                    'tooltipMouse': PointSelection(on: {
                      GestureType.hover,
                    }, devices: {
                      PointerDeviceKind.mouse
                    }, variable: 'day'),
                    'groupMouse': PointSelection(
                        on: {
                          GestureType.hover,
                        },
                        variable: 'group',
                        devices: {PointerDeviceKind.mouse}),
                    'tooltipTouch': PointSelection(on: {
                      GestureType.scaleUpdate,
                      GestureType.tapDown,
                      GestureType.longPressMoveUpdate
                    }, devices: {
                      PointerDeviceKind.touch
                    }, variable: 'day'),
                    'groupTouch': PointSelection(
                        on: {
                          GestureType.scaleUpdate,
                          GestureType.tapDown,
                          GestureType.longPressMoveUpdate
                        },
                        variable: 'group',
                        devices: {PointerDeviceKind.touch}),
                  },
                  tooltip: TooltipGuide(
                    selections: {'tooltipTouch', 'tooltipMouse'},
                    followPointer: [true, true],
                    align: Alignment.topLeft,
                  ),
                  crosshair: CrosshairGuide(
                    selections: {'tooltipTouch', 'tooltipMouse'},
                    followPointer: [false, true],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Linear chart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                height: 600,
                child: Chart(
                  data: lineMarkerData2,
                  variables: {
                    'day': Variable(
                      accessor: (Map datum) => datum['day'] as String,
                      scale: OrdinalScale(inflate: true),
                    ),
                    'value': Variable(
                      accessor: (Map datum) => datum['value'] as num,
                      scale: LinearScale(
                        max: 15,
                        min: -3,
                        tickCount: 7,
                        formatter: (v) => '${v.toInt()} ℃',
                      ),
                    ),
                    'group': Variable(
                      accessor: (Map datum) => datum['group'] as String,
                    ),
                  },
                  marks: [
                    LineMark(
                      position:
                          Varset('day') * Varset('value') / Varset('group'),
                      color: ColorEncode(
                        variable: 'group',
                        values: [
                          const Color(0xff5470c6),
                          const Color(0xff91cc75),
                        ],
                      ),
                    ),
                  ],
                  axes: [
                    Defaults.horizontalAxis,
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
                    followPointer: [true, true],
                    align: Alignment.topLeft,
                    variables: ['group', 'value'],
                  ),
                  crosshair: CrosshairGuide(
                    followPointer: [false, true],
                  ),
                  annotations: [
                    LineAnnotation(
                      dim: Dim.y,
                      value: 11.14,
                      style: PaintStyle(
                        strokeColor: const Color(0xff5470c6).withAlpha(100),
                        dash: [2],
                      ),
                    ),
                    LineAnnotation(
                      dim: Dim.y,
                      value: 1.57,
                      style: PaintStyle(
                        strokeColor: const Color(0xff91cc75).withAlpha(100),
                        dash: [2],
                      ),
                    ),
                    CustomAnnotation(
                      values: ['day', 'values'], // TODO TERMINAR ESTA MADRE!
                      renderer: (offset, _) => [
                        CircleElement(
                            center: offset,
                            radius: 5,
                            style:
                                PaintStyle(fillColor: const Color(0xff5470c6)))
                      ],
                      // values: ['Wed', 10],
                    ),
                    // TagAnnotation(
                    //     variables: ['day', 'values'],

                    //   label: Label(
                    //       '13',
                    //       LabelStyle(
                    //         textStyle: Defaults.textStyle,
                    //         offset: const Offset(0, -10),
                    //       )),
                    // values: ['Wed', 10],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
