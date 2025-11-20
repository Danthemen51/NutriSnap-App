import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calendar_data.dart';
import '../models/food_item.dart';
import '../models/meal.dart';

// Provider untuk calendar data
final calendarProvider = StateProvider<List<CalendarData>>((ref) {
  return [];
});

// Provider untuk selected date index
final selectedDateIndexProvider = StateProvider<int>((ref) => 3);

// Provider untuk bottom navigation
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Provider untuk scroll controller state
final scrollStateProvider = StateProvider<({bool isHeaderVisible, double lastOffset})>((ref) {
  return (isHeaderVisible: true, lastOffset: 0);
});

// Provider untuk recently eaten foods
final recentlyEatenProvider = StateProvider<List<FoodItem>>((ref) {
  return [];
});

// Provider untuk consumed nutrients (akan diupdate otomatis)
final consumedNutrientsProvider = StateProvider<Map<String, double>>((ref) {
  return {
    'calories': 0.0,
    'protein': 0.0,
    'carbs': 0.0,
    'fat': 0.0,
    'fiber': 0.0,
  };
});

// Provider untuk meal plan data
final mealPlanProvider = StateProvider<List<Meal>>((ref) {
  return [
    Meal(
      name: 'Breakfast',
      time: '07:00',
      calories: 450,
      icon: 'breakfast',
      color: 0xFFFFB74D,
    ),
    Meal(
      name: 'Snack',
      time: '10:00',
      calories: 150,
      icon: 'coffee',
      color: 0xFF4FC3F7,
    ),
    Meal(
      name: 'Lunch',
      time: '13:00',
      calories: 650,
      icon: 'lunch',
      color: 0xFF81C784,
    ),
    Meal(
      name: 'Snack',
      time: '16:00',
      calories: 200,
      icon: 'snack',
      color: 0xFFBA68C8,
    ),
    Meal(
      name: 'Dinner',
      time: '19:00',
      calories: 550,
      icon: 'dinner',
      color: 0xFF4DB6AC,
    ),
    Meal(
      name: 'Snack',
      time: '21:00',
      calories: 100,
      icon: 'night',
      color: 0xFF7986CB,
    ),
  ];
});

// Provider untuk user data
final userDataProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'name': 'Dandi',
    'dailyCaloriesTarget': 2500,
    'proteinTarget': 65,
    'carbsTarget': 200,
    'fatTarget': 50,
    'fiberTarget': 30,
  };
});

// Provider untuk daily goals (target harian)
final dailyGoalsProvider = StateProvider<Map<String, dynamic>>((ref) {
  final userData = ref.watch(userDataProvider);
  return {
    'calories': userData['dailyCaloriesTarget'],
    'protein': userData['proteinTarget'],
    'carbs': userData['carbsTarget'],
    'fat': userData['fatTarget'],
    'fiber': userData['fiberTarget'],
  };
});

// Provider untuk progress calculation
final nutritionProgressProvider = Provider<Map<String, double>>((ref) {
  final consumed = ref.watch(consumedNutrientsProvider);
  final goals = ref.watch(dailyGoalsProvider);
  
  return {
    'calories': (consumed['calories']! / goals['calories']!).clamp(0.0, 1.0),
    'protein': (consumed['protein']! / goals['protein']!).clamp(0.0, 1.0),
    'carbs': (consumed['carbs']! / goals['carbs']!).clamp(0.0, 1.0),
    'fat': (consumed['fat']! / goals['fat']!).clamp(0.0, 1.0),
    'fiber': (consumed['fiber']! / goals['fiber']!).clamp(0.0, 1.0),
  };
});

// Provider untuk calories left
final caloriesLeftProvider = Provider<int>((ref) {
  final goals = ref.watch(dailyGoalsProvider);
  final consumed = ref.watch(consumedNutrientsProvider);
  
  final caloriesLeft = goals['calories']! - consumed['calories']!;
  return caloriesLeft > 0 ? caloriesLeft.toInt() : 0;
});

// Helper function untuk update consumed nutrients
class NutritionService {
  static void addFoodToConsumed(WidgetRef ref, FoodItem food) {
    // Update recently eaten
    final currentList = ref.read(recentlyEatenProvider);
    ref.read(recentlyEatenProvider.notifier).state = [food, ...currentList];
    
    // Update consumed nutrients
    final currentNutrients = ref.read(consumedNutrientsProvider);
    ref.read(consumedNutrientsProvider.notifier).state = {
      'calories': currentNutrients['calories']! + food.calories,
      'protein': currentNutrients['protein']! + food.protein,
      'carbs': currentNutrients['carbs']! + food.carbs,
      'fat': currentNutrients['fat']! + food.fat,
      'fiber': currentNutrients['fiber']! + food.fiber,
    };
  }
  
  static void resetDailyNutrition(WidgetRef ref) {
    ref.read(consumedNutrientsProvider.notifier).state = {
      'calories': 0.0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
      'fiber': 0.0,
    };
    ref.read(recentlyEatenProvider.notifier).state = [];
  }
}