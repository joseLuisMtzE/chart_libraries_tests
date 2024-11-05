import 'package:chart_libraries_tests/presentation/screens/msp_charts/msp_charts_screen.dart';
import 'package:flutter/material.dart';

class CalendarSegmentedButton extends StatelessWidget {
  final Calendar selectedCalendar;
  final ValueChanged<Calendar> onSelectionChanged;

  const CalendarSegmentedButton({
    super.key,
    required this.selectedCalendar,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SegmentedButton<Calendar>(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        side: WidgetStatePropertyAll(BorderSide(
          color: colorScheme.primary,
        )),
        foregroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return colorScheme.primary;
        }),
        backgroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.white; // Color para el botón no seleccionado
        }),
      ),
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.week,
          label: Text('SEMANAL'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.month,
          label: Text('MENSUAL'),
          icon: Icon(Icons.calendar_view_month),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.year,
          label: Text('ANUAL'),
          icon: Icon(Icons.calendar_today),
        ),
      ],
      selected: <Calendar>{selectedCalendar},
      onSelectionChanged: (Set<Calendar> newSelection) {
        onSelectionChanged(newSelection.first);
      },
    );
  }
}
