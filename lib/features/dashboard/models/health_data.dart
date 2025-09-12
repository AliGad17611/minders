import 'package:flutter/animation.dart';

class HealthData {
  final String title;
  final double percentage;
  final String icon;
  final Color color;

  HealthData({
    required this.title,
    required this.percentage,
    required this.icon,
    required this.color,
  });
}

class ActivityData {
  final String name;
  final String time;
  final String avatar;

  ActivityData({
    required this.name,
    required this.time,
    required this.avatar,
  });
}

class GoalData {
  final String name;
  final List<String> days;
  bool isSelected;

  GoalData({
    required this.name,
    required this.days,
    this.isSelected = false,
  });
}