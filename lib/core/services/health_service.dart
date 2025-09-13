
import 'package:flutter/animation.dart';
import 'package:minders/features/dashboard/models/health_data.dart';

class HealthService {
  static Future<List<HealthData>> getHealthData() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));

    return [
      HealthData(
        title: 'Drinking water',
        percentage: 75,
        icon: '💧',
        color: Color(0xFF06B6D4),
      ),
      HealthData(
        title: 'Cycling',
        percentage: 40,
        icon: '🚴',
        color: Color(0xFFF59E0B),
      ),
      HealthData(
        title: 'Water',
        percentage: 40,
        icon: '💧',
        color: Color(0xFF8B5CF6),
      ),
      HealthData(
        title: 'Walking',
        percentage: 40,
        icon: '🚶',
        color: Color(0xFF10B981),
      ),
    ];
  }

  static Future<List<ActivityData>> getActivities() async {
    await Future.delayed(Duration(milliseconds: 300));

    return [
      ActivityData(
        name: 'Drinking 500ml Water',
        time: 'About 8 minutes ago',
        avatar: '👤',
      ),
      ActivityData(
        name: 'Eat Snack (Fruit)',
        time: 'About 10 minutes ago',
        avatar: '👤',
      ),
    ];
  }

  static Future<List<double>> getWeeklyProgress() async {
    await Future.delayed(Duration(milliseconds: 200));

    return [0.6, 0.8, 0.7, 0.9, 0.5, 0.4, 0.8];
  }
}