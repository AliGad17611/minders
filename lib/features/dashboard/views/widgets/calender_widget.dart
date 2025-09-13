import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:minders/core/utils/themes/app_colors.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const CalendarWidget({super.key, this.onDateSelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: CalendarTimeline(
        initialDate: _selectedDate,
        firstDate: DateTime(2020, 1, 1),
        lastDate: DateTime(2030, 12, 31),
        onDateSelected: _onDateSelected,
        leftMargin: 20,
        monthColor: Colors.white,
        dayColor: Colors.white,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: AppColors.purpleAccent,
        selectableDayPredicate: (date) => true,
        locale: 'en_US',
        // Basic styling
        height: 100,
      ),
    );
  }
}
