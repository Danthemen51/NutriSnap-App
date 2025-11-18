import 'package:flutter/material.dart';

class RecentlyEatenSection extends StatelessWidget {
  const RecentlyEatenSection({Key? key}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Recently Eaten',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 16),

          // Food Items List
          Column(
            children: [
              _RecentlyEatenItem(
                foodName: 'Fried Chicken Bowl',
                calories: 250,
                nutrients: [
                  NutrientInfo(
                    type: 'carb',
                    amount: 6,
                    color: Color(0xFFFF9800),
                  ),
                  NutrientInfo(
                    type: 'protein',
                    amount: 30,
                    color: Color(0xFF2196F3),
                  ),
                  NutrientInfo(
                    type: 'fat',
                    amount: 12,
                    color: Color(0xFFF44336),
                  ),
                  NutrientInfo(
                    type: 'fibre',
                    amount: 12,
                    color: Color(0xFF9C27B0),
                  ),
                ],
                time: '18:10',
                date: 'Today',
                imageUrl: 'assets/images/chicken_bowl.jpg',
              ),
              SizedBox(height: 12),
              _RecentlyEatenItem(
                foodName: 'Greek Yogurt with Berries',
                calories: 180,
                nutrients: [
                  NutrientInfo(
                    type: 'protein',
                    amount: 15,
                    color: Color(0xFF2196F3),
                  ),
                  NutrientInfo(
                    type: 'carb',
                    amount: 20,
                    color: Color(0xFFFF9800),
                  ),
                  NutrientInfo(
                    type: 'fibre',
                    amount: 5,
                    color: Color(0xFF9C27B0),
                  ),
                ],
                time: '15:30',
                date: 'Today',
                imageUrl: 'assets/images/greek_yogurt.jpg',
              ),
              SizedBox(height: 12),
              _RecentlyEatenItem(
                foodName: 'Avocado Toast',
                calories: 320,
                nutrients: [
                  NutrientInfo(
                    type: 'carb',
                    amount: 35,
                    color: Color(0xFFFF9800),
                  ),
                  NutrientInfo(
                    type: 'fat',
                    amount: 18,
                    color: Color(0xFFF44336),
                  ),
                  NutrientInfo(
                    type: 'fibre',
                    amount: 9,
                    color: Color(0xFF9C27B0),
                  ),
                ],
                time: '12:45',
                date: 'Today',
                imageUrl: 'assets/images/avocado_toast.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentlyEatenItem extends StatelessWidget {
  final String foodName;
  final int calories;
  final List<NutrientInfo> nutrients;
  final String time;
  final String date;
  final String imageUrl;

  const _RecentlyEatenItem({
    Key? key,
    required this.foodName,
    required this.calories,
    required this.nutrients,
    required this.time,
    required this.date,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          // Food Image dengan custom loading state
          _FoodImageWithLoading(imageUrl: imageUrl),
          SizedBox(width: 12),

          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name
                Text(
                  foodName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),

                // Calories
                Text(
                  '$calories Calories',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF00E676),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 6),

                // Nutrition Details
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: nutrients
                      .map(
                        (nutrient) => _NutritionChip(
                          text: '+ ${nutrient.amount}g ${nutrient.type}',
                          color: nutrient.color,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget terpisah untuk menangani image dengan loading state
class _FoodImageWithLoading extends StatefulWidget {
  final String imageUrl;

  const _FoodImageWithLoading({Key? key, required this.imageUrl}) : super(key: key);

  @override
  __FoodImageWithLoadingState createState() => __FoodImageWithLoadingState();
}

class __FoodImageWithLoadingState extends State<_FoodImageWithLoading> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay untuk asset images
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF00E676),
            ),
          ),
        ),
      );
    }

    if (_hasError) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.fastfood,
          color: Colors.grey[500],
          size: 24,
        ),
      );
    }

    return Image.asset(
      widget.imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Set error state untuk future builds
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.fastfood,
            color: Colors.grey[500],
            size: 24,
          ),
        );
      },
    );
  }
}

class _NutritionChip extends StatelessWidget {
  final String text;
  final Color color;

  const _NutritionChip({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class NutrientInfo {
  final String type;
  final int amount;
  final Color color;

  NutrientInfo({required this.type, required this.amount, required this.color});
}