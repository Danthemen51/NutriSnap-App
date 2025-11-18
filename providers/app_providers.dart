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

// Provider untuk makanan data
final foodListProvider = StateProvider<List<FoodItem>>((ref) {
  return [
    FoodItem(
      name: 'Apple',
      calories: 95,
      protein: 0.5,
      carbs: 25,
      fat: 0.3,
      imageUrl: 'assets/images/apple.jpg',
    ),
    FoodItem(
      name: 'Grilled Chicken',
      calories: 165,
      protein: 31,
      carbs: 0,
      fat: 3.6,
      imageUrl: 'assets/images/chicken.jpg',
    ),
    FoodItem(
      name: 'Brown Rice',
      calories: 216,
      protein: 5,
      carbs: 45,
      fat: 1.8,
      imageUrl: 'assets/images/rice.jpg',
    ),
    FoodItem(
      name: 'Salad',
      calories: 50,
      protein: 2,
      carbs: 8,
      fat: 1,
      imageUrl: 'assets/images/salad.jpg',
    ),
    FoodItem(
      name: 'Yogurt',
      calories: 150,
      protein: 8,
      carbs: 12,
      fat: 4,
      imageUrl: 'assets/images/yogurt.jpg',
    ),
  ];
});

// Provider untuk meal plan data
final mealPlanProvider = StateProvider<List<Meal>>((ref) {
  return [
    Meal(
      name: 'Breakfast',
      time: '07:00 AM',
      calories: 450,
      icon: 'breakfast',
      color: 0xFFFFB74D,
    ),
    Meal(
      name: 'Morning Snack',
      time: '10:00 AM',
      calories: 150,
      icon: 'coffee',
      color: 0xFF4FC3F7,
    ),
    Meal(
      name: 'Lunch',
      time: '01:00 PM',
      calories: 650,
      icon: 'lunch',
      color: 0xFF81C784,
    ),
    Meal(
      name: 'Afternoon Snack',
      time: '04:00 PM',
      calories: 200,
      icon: 'snack',
      color: 0xFFBA68C8,
    ),
    Meal(
      name: 'Dinner',
      time: '07:00 PM',
      calories: 550,
      icon: 'dinner',
      color: 0xFF4DB6AC,
    ),
    Meal(
      name: 'Evening Snack',
      time: '09:00 PM',
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
    'fibreTarget': 30,
  };
});

// Provider untuk consumed nutrients
final consumedNutrientsProvider = StateProvider<Map<String, double>>((ref) {
  return {
    'calories': 1250.0,
    'protein': 30.0,
    'carbs': 120.0,
    'fat': 15.0,
    'fibre': 18.0,
  };
});