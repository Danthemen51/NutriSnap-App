import 'package:flutter/material.dart';
import '../models/calendar_data.dart';

class CalendarSection extends StatelessWidget {
  final List<CalendarData> calendarData;
  final Function(int)? onDateSelected;

  const CalendarSection({
    Key? key,
    required this.calendarData,
    this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Days Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: calendarData.map((data) {
            return Container(
              width: 40,
              child: Center(
                child: Text(
                  data.day,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12),

        // Dates Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: calendarData.asMap().entries.map((entry) {
            int index = entry.key;
            CalendarData data = entry.value;
            return GestureDetector(
              onTap: () => onDateSelected?.call(index),
              child: Container(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: data.isSelected
                            ? Color(0xFF4CAF50)
                            : data.isToday
                            ? Color(0xFFE8F5E8)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: data.isToday && !data.isSelected
                            ? Border.all(color: Color(0xFF4CAF50), width: 1)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          data.date,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: data.isSelected
                                ? Colors.white
                                : data.isToday
                                ? Color(0xFF4CAF50)
                                : Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
