import 'package:flutter/material.dart';

class MacrosSection extends StatelessWidget {
  const MacrosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
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
        children: [
          // Title Row
          const Row(
            children: [
              Icon(
                Icons.dashboard,
                color: Color(0xFF00E676),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Daily Needs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 20),
          
          // First Row: Protein and Carbs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              MacroItem(
                title: 'Protein left',
                consumed: 30,
                target: 65,
                color: Color(0xFF2196F3),
              ),
              MacroItem(
                title: 'Carbs left',
                consumed: 120,
                target: 200,
                color: Color(0xFFFF9800),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Second Row: Fat and Fibre
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              MacroItem(
                title: 'Fat left',
                consumed: 15,
                target: 50,
                color: Color(0xFFF44336),
              ),
              MacroItem(
                title: 'Fibre left',
                consumed: 18,
                target: 30,
                color: Color(0xFF9C27B0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MacroItem extends StatelessWidget {
  final String title;
  final int consumed;
  final int target;
  final Color color;

  const MacroItem({
    super.key,
    required this.title,
    required this.consumed,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final left = target - consumed;
    final progress = consumed / target;

    return Column(
      children: [
        // Circular Progress Container
        Container(
          width: 80,
          height: 80,
          child: Stack(
            children: [
              // Background circle
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[50],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),

              // Progress circle
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: Colors.grey[300],
                ),
              ),

              // Center content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$left',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: color,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Text(
                      'left',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Info section
        Column(
          children: [
            // Title with icon
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 14,
                  color: Color(0xFF00E676),
                ),
                SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$consumed/${target}g',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}