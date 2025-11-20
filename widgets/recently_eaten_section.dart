import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food_item.dart';
import '../providers/app_providers.dart';
import 'dart:io';

class RecentlyEatenSection extends ConsumerWidget {
  const RecentlyEatenSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyEaten = ref.watch(recentlyEatenProvider);

    if (recentlyEaten.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
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
          // Section Title
          Row(
            children: [
              Icon(
                Icons.history,
                color: Color(0xFF00E676),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Recently Eaten',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Food Items List
          Column(
            children: recentlyEaten.take(3).map((food) => 
              _RecentlyEatenItem(food: food)
            ).toList(),
          ),

          // Show More Button jika ada lebih dari 3 item
          if (recentlyEaten.length > 3) 
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to full history screen
                  },
                  child: Text(
                    'View All (${recentlyEaten.length})',
                    style: TextStyle(
                      color: Color(0xFF00E676),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
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
          // Section Title
          Row(
            children: [
              Icon(
                Icons.history,
                color: Color(0xFF00E676),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Recently Eaten',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Empty State
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.fastfood_outlined,
                  color: Colors.grey[400],
                  size: 48,
                ),
                SizedBox(height: 12),
                Text(
                  'No food items yet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Foods you add will appear here',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  '💡 Tip: Tap on meal times in "Today\'s Meal Plan" to add food',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[400],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentlyEatenItem extends StatelessWidget {
  final FoodItem food;

  const _RecentlyEatenItem({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          // Food Image
          _FoodImageWithLoading(imageUrl: food.imageUrl),
          SizedBox(width: 12),

          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name
                Text(
                  food.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),

                // Calories
                Text(
                  '${food.calories} Calories',
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
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if (food.protein > 0)
                      _NutritionChip(
                        text: '${food.protein}g protein',
                        color: Color(0xFF2196F3),
                      ),
                    if (food.carbs > 0)
                      _NutritionChip(
                        text: '${food.carbs}g carbs',
                        color: Color(0xFFFF9800),
                      ),
                    if (food.fat > 0)
                      _NutritionChip(
                        text: '${food.fat}g fat',
                        color: Color(0xFFF44336),
                      ),
                    if (food.fiber > 0)
                      _NutritionChip(
                        text: '${food.fiber}g fiber',
                        color: Color(0xFF9C27B0),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Time and Meal Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(food.consumedAt),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getMealTypeColor(food.mealType),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  food.mealType,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Color _getMealTypeColor(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Color(0xFFFFB74D);
      case 'lunch':
        return Color(0xFF81C784);
      case 'dinner':
        return Color(0xFF4DB6AC);
      case 'snack':
        return Color(0xFFBA68C8);
      default:
        return Color(0xFF00E676);
    }
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
          color: Color(0xFF00E676).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.fastfood,
          color: Color(0xFF00E676),
          size: 24,
        ),
      );
    }

    // Handle local file images - periksa apakah ini path file lokal
    bool isLocalFile = widget.imageUrl.startsWith('/') || 
                      widget.imageUrl.startsWith('file://') ||
                      !widget.imageUrl.contains('http');

    if (isLocalFile) {
      // Untuk local file images, gunakan Image.file
      try {
        return Image.file(
          File(widget.imageUrl.replaceAll('file://', '')),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                });
              }
            });
            return _buildErrorState();
          },
        );
      } catch (e) {
        return _buildErrorState();
      }
    } else {
      // Untuk network images, gunakan Image.network seperti sebelumnya
      return Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _hasError = true;
              });
            }
          });
          return _buildErrorState();
        },
      );
    }
  }

  Widget _buildErrorState() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF00E676).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.fastfood,
        color: Color(0xFF00E676),
        size: 24,
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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