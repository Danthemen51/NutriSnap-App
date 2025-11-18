// lib/widgets/categories_section.dart
import 'package:flutter/material.dart';
import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  final Color primaryColor;
  const CategoriesSection({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Hairdresser', 'icon': Icons.dry_cleaning_outlined},
      {'name': 'Cleaning', 'icon': Icons.cleaning_services_outlined},
      {'name': 'Painting', 'icon': Icons.palette_outlined},
      {'name': 'Cooking', 'icon': Icons.restaurant_menu_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Service Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View all >',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Grid 2x2 untuk Kategori
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 2.2, // Kontrol lebar/tinggi kartu
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                title: categories[index]['name'] as String,
                icon: categories[index]['icon'] as IconData,
                primaryColor: primaryColor,
              );
            },
          ),
        ],
      ),
    );
  }
}