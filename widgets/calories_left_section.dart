import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';

class CaloriesLeftSection extends ConsumerWidget {
  const CaloriesLeftSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caloriesLeft = ref.watch(caloriesLeftProvider);
    final dailyGoals = ref.watch(dailyGoalsProvider);
    final consumed = ref.watch(consumedNutrientsProvider);
    final progress = ref.watch(nutritionProgressProvider);

    final caloriesConsumed = consumed['calories']!.toInt();
    final dailyTarget = dailyGoals['calories']!;
    final progressValue = progress['calories']!;

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
                      'Kalori tersisa',
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
                  'Target harian: $dailyTarget kcal',
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
                  'kcal tersisa',
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
                  // Progress Fill - OTOMATIS berdasarkan caloriesConsumed
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
                  'Terkonsumsi: $caloriesConsumed kcal',
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