import 'package:flutter/material.dart';

class StatsSection extends StatefulWidget {
  @override
  _StatsSectionState createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  late int _steps;
  late double _distance;
  late int _stops;

  @override
  void initState() {
    super.initState();
    _generateRandomStats();
  }

  void _generateRandomStats() {
    final random = DateTime.now().millisecond;

    setState(() {
      _steps = 4000 + (random % 2000);
      _distance = 3.5 + (random % 200) / 100;
      _stops = 1200 + (random % 200);
    });
  }

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(value: _stops.toString(), label: 'Stops'),
          _buildStatItem(value: _distance.toStringAsFixed(1), label: 'Km'),
          _buildStatItem(value: _steps.toString(), label: 'Steps'),
        ],
      ),
    );
  }

  Widget _buildStatItem({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
