// models/food_item.dart
class FoodItem {
  final String id;
  final String name;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final String imageUrl;
  final DateTime consumedAt;
  final String mealType;

  FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.imageUrl,
    required this.consumedAt,
    required this.mealType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'imageUrl': imageUrl,
      'consumedAt': consumedAt.toIso8601String(),
      'mealType': mealType,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      calories: map['calories'] ?? 0,
      protein: map['protein']?.toDouble() ?? 0.0,
      carbs: map['carbs']?.toDouble() ?? 0.0,
      fat: map['fat']?.toDouble() ?? 0.0,
      fiber: map['fiber']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      consumedAt: DateTime.parse(map['consumedAt']),
      mealType: map['mealType'] ?? 'breakfast',
    );
  }
}