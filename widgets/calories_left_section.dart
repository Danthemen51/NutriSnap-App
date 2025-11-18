import 'package:flutter/material.dart';

class CaloriesLeftSection extends StatelessWidget {
  const CaloriesLeftSection({super.key});

  @override
  Widget build(BuildContext context) {
    int caloriesLeft = 500;
    int dailyTarget = 2500;
    int caloriesConsumed = dailyTarget - caloriesLeft;
    double progressValue = caloriesConsumed / dailyTarget;

    return Column(
      children: [
        // Main Calories Info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 16,
                      color: Color(0xFF00E676),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Calories left',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Daily target: $dailyTarget kcal',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // Value Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$caloriesLeft',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00E676),
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'kcal left',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // Progress Bar dengan label di ujung
        Column(
          children: [
            // Progress Bar
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(3),
              ),
              child: Stack(
                children: [
                  // Progress Fill
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth * progressValue,
                        decoration: BoxDecoration(
                          color: Color(0xFF00E676),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),

            // Progress Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consumed: $caloriesConsumed kcal',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Target: $dailyTarget kcal',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}