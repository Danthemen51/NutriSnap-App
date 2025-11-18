import 'package:flutter/material.dart';
import '../models/calendar_data.dart';

class AnimatedCalendarSection extends StatefulWidget {
  final List<CalendarData> calendarData;
  final Function(int) onDateSelected;

  const AnimatedCalendarSection({
    Key? key,
    required this.calendarData,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _AnimatedCalendarSectionState createState() => _AnimatedCalendarSectionState();
}

class _AnimatedCalendarSectionState extends State<AnimatedCalendarSection> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.calendarData.length, (index) {
                return _AnimatedCalendarItem(
                  data: widget.calendarData[index],
                  index: index,
                  onTap: () => widget.onDateSelected(index),
                  animation: _animation,
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedCalendarItem extends StatelessWidget {
  final CalendarData data;
  final int index;
  final VoidCallback onTap;
  final Animation<double> animation;

  const _AnimatedCalendarItem({
    required this.data,
    required this.index,
    required this.onTap,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final itemAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.1 + (0.1 * index),
          0.6 + (0.1 * index),
          curve: Curves.easeOutBack,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: itemAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: onTap,
          child: Transform.scale(
            scale: itemAnimation.value,
            child: Container(
              width: 45,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: data.isSelected 
                    ? Color(0xFF00E676) 
                    : data.isToday 
                        ? Color(0xFF00E676).withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: data.isToday && !data.isSelected
                    ? Border.all(color: Color(0xFF00E676).withOpacity(0.3))
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    data.day,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: data.isSelected ? Colors.white : Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    data.date,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: data.isSelected ? Colors.white : Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}