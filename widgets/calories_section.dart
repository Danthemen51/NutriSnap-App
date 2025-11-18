import 'package:flutter/material.dart';

class CaloriesSection extends StatefulWidget {
  @override
  _CaloriesSectionState createState() => _CaloriesSectionState();
}

class _CaloriesSectionState extends State<CaloriesSection> {
  late int _caloriesBurned;
  late int _caloriesConsumed;

  @override
  void initState() {
    super.initState();
    _generateCaloriesData();
  }

  void _generateCaloriesData() {
    final random = DateTime.now().millisecond;

    setState(() {
      _caloriesBurned = 3200 + (random % 500);
      _caloriesConsumed = 2100 + (random % 400);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Calories Burned',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCaloriesCircle(
                value: _caloriesBurned.toString(),
                label: 'Kcal Burned',
                color: Color(0xFF4CAF50),
              ),
              _buildCaloriesCircle(
                value: _caloriesConsumed.toString(),
                label: 'Kcal Consumed',
                color: Color(0xFF2196F3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesCircle({
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'Kcal',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
