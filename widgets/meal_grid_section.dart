import 'package:flutter/material.dart';

class MealGridSection extends StatelessWidget {
  const MealGridSection({super.key});

  // Helper function untuk mendapatkan data meals
  List<Map<String, dynamic>> _getMeals() {
    return [
      {
        'name': 'Breakfast',
        'time': '07:00',
        'calories': 450,
        'icon': Icons.free_breakfast,
        'color': 0xFFFFB74D,
      },
      {
        'name': 'Morning Snack',
        'time': '10:00',
        'calories': 150,
        'icon': Icons.coffee,
        'color': 0xFF4FC3F7,
      },
      {
        'name': 'Lunch',
        'time': '13:00',
        'calories': 650,
        'icon': Icons.lunch_dining,
        'color': 0xFF81C784,
      },
      {
        'name': 'Afternoon Snack',
        'time': '16:00',
        'calories': 200,
        'icon': Icons.cookie,
        'color': 0xFFBA68C8,
      },
      {
        'name': 'Dinner',
        'time': '19:00',
        'calories': 550,
        'icon': Icons.dinner_dining,
        'color': 0xFF4DB6AC,
      },
      {
        'name': 'Evening Snack',
        'time': '21:00',
        'calories': 100,
        'icon': Icons.nightlight_round,
        'color': 0xFF7986CB,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final meals = _getMeals();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16), // ✅ Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          const Row(
            children: [
              Icon(
                Icons.schedule,
                color: Color(0xFF00E676),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Today\'s Meal Plan',
                style: TextStyle(
                  fontSize: 16, // ✅ Slightly smaller
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Grid View dengan aspect ratio yang optimal untuk Android
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10, // ✅ Reduced spacing
              mainAxisSpacing: 10,  // ✅ Reduced spacing
              childAspectRatio: 1.6, // ✅ Optimal untuk Android
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return _MealCard(meal: meal);
            },
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Map<String, dynamic> meal;

  const _MealCard({
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(meal['color']).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(meal['color']).withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10), // ✅ Compact padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon and Name Row - Compact tapi readable
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6), // ✅ Balanced padding
                  decoration: BoxDecoration(
                    color: Color(meal['color']),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    meal['icon'],
                    color: Colors.white,
                    size: 18, // ✅ Good size for Android
                  ),
                ),
                const SizedBox(width: 6), // ✅ Compact spacing
                Expanded(
                  child: Text(
                    meal['name'],
                    style: const TextStyle(
                      fontSize: 13, // ✅ Readable but compact
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            // Time and Calories Column - Compact layout
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['time'],
                  style: const TextStyle(
                    fontSize: 11, // ✅ Compact but readable
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2), // ✅ Minimal spacing
                Text(
                  '${meal['calories']} kcal',
                  style: TextStyle(
                    fontSize: 13, // ✅ Good balance
                    fontWeight: FontWeight.w700,
                    color: Color(meal['color']),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}