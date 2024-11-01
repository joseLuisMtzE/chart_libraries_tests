import 'package:graphic/graphic.dart';
import 'package:flutter/material.dart';

import './data.dart';

class CircularGraphicScreen extends StatelessWidget {
  const CircularGraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: 350,
          height: 300,
          child: Chart(
            rebuild: false,
            data: basicData,
            variables: {
              'genre': Variable(
                accessor: (Map map) => map['genre'] as String,
              ),
              'sold': Variable(
                accessor: (Map map) => map['sold'] as num,
              ),
            },
            transforms: [
              Proportion(
                variable: 'sold',
                as: 'percent',
              )
            ],
            marks: [
              IntervalMark(
                position: Varset('percent') / Varset('genre'),
                label: LabelEncode(
                    encoder: (tuple) => Label(
                          tuple['sold'].toString(),
                          LabelStyle(
                              textStyle: TextStyle(fontWeight: FontWeight.bold)
                              // Defaults.runeStyle
                              ),
                        )),
                color:
                    ColorEncode(variable: 'genre', values: Defaults.colors10),
                modifiers: [StackModifier()],
                entrance: {MarkEntrance.y},
              )
            ],
            coord: PolarCoord(transposed: true, dimCount: 1),
          ),
        ),
      ),
    );
  }
}
