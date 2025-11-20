import 'package:flutter/material.dart';
import 'food_input_dialog.dart';

class MealGridSection extends StatelessWidget {
  const MealGridSection({super.key});

  // Helper function untuk mendapatkan data meals (simplified to 4 items)
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
        'name': 'Lunch',
        'time': '12:00',
        'calories': 650,
        'icon': Icons.lunch_dining,
        'color': 0xFF81C784,
      },
      {
        'name': 'Snack',
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final meals = _getMeals();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Grid View dengan 4 items (2x2 grid)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
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

  void _showFoodInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FoodInputDialog(mealType: meal['name']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFoodInputDialog(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: Color(meal['color']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(meal['color']).withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and Name Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(meal['color']),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(meal['color']).withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        meal['icon'],
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal['name'],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tap to add food',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Time and Calories Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 10,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          meal['time'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${meal['calories']} kcal',
                      style: TextStyle(
                        fontSize: 13,
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
        ),
      ),
    );
  }
}