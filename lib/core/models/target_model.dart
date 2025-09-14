import 'package:flutter/material.dart';

enum TargetType {
  water,
  steps,
  sleep,
  calories,
  exercise,
  meditation,
  reading,
  custom
}

class TargetModel {
  final String id;
  final String title;
  final String emoji;
  final TargetType type;
  final double targetValue;
  final double currentValue;
  final String unit;
  final Color color;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isCompleted;

  TargetModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.type,
    required this.targetValue,
    this.currentValue = 0.0,
    required this.unit,
    required this.color,
    required this.createdAt,
    this.completedAt,
    this.isCompleted = false,
  });

  double get progressPercentage {
    if (targetValue == 0) return 0.0;
    return (currentValue / targetValue * 100).clamp(0.0, 100.0);
  }

  TargetModel copyWith({
    String? id,
    String? title,
    String? emoji,
    TargetType? type,
    double? targetValue,
    double? currentValue,
    String? unit,
    Color? color,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isCompleted,
  }) {
    return TargetModel(
      id: id ?? this.id,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  String get displayText {
    return '${currentValue.toInt()}/${targetValue.toInt()} $unit';
  }

  String get activityDescription {
    switch (type) {
      case TargetType.water:
        return 'Drank ${currentValue.toInt()} $unit of water';
      case TargetType.steps:
        return 'Walked ${currentValue.toInt()} $unit';
      case TargetType.sleep:
        return 'Slept for ${currentValue.toInt()} $unit';
      case TargetType.calories:
        return 'Burned ${currentValue.toInt()} $unit';
      case TargetType.exercise:
        return 'Exercised for ${currentValue.toInt()} $unit';
      case TargetType.meditation:
        return 'Meditated for ${currentValue.toInt()} $unit';
      case TargetType.reading:
        return 'Read for ${currentValue.toInt()} $unit';
      case TargetType.custom:
        return '$title: ${currentValue.toInt()} $unit';
    }
  }

  static List<TargetModel> getDefaultTargets() {
    return [
      TargetModel(
        id: 'water_1',
        title: 'Water Intake',
        emoji: '💧',
        type: TargetType.water,
        targetValue: 8,
        currentValue: 0,
        unit: 'glasses',
        color: const Color(0xFF06B6D4),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'steps_1',
        title: 'Daily Steps',
        emoji: '👟',
        type: TargetType.steps,
        targetValue: 10000,
        currentValue: 0,
        unit: 'steps',
        color: const Color(0xFFF59E0B),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'sleep_1',
        title: 'Sleep Duration',
        emoji: '😴',
        type: TargetType.sleep,
        targetValue: 8,
        currentValue: 0,
        unit: 'hours',
        color: const Color(0xFF8B5CF6),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'exercise_1',
        title: 'Exercise',
        emoji: '🏋️',
        type: TargetType.exercise,
        targetValue: 60,
        currentValue: 0,
        unit: 'minutes',
        color: const Color(0xFF10B981),
        createdAt: DateTime.now(),
      ),
    ];
  }

  static List<TargetModel> getAvailableTargetTemplates() {
    return [
      TargetModel(
        id: 'template_water',
        title: 'Water Intake',
        emoji: '💧',
        type: TargetType.water,
        targetValue: 8,
        unit: 'glasses',
        color: const Color(0xFF06B6D4),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'template_steps',
        title: 'Daily Steps',
        emoji: '👟',
        type: TargetType.steps,
        targetValue: 10000,
        unit: 'steps',
        color: const Color(0xFFF59E0B),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'template_calories',
        title: 'Calories Burned',
        emoji: '🔥',
        type: TargetType.calories,
        targetValue: 500,
        unit: 'calories',
        color: const Color(0xFFEF4444),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'template_meditation',
        title: 'Meditation',
        emoji: '🧘',
        type: TargetType.meditation,
        targetValue: 20,
        unit: 'minutes',
        color: const Color(0xFF8B5CF6),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'template_reading',
        title: 'Reading',
        emoji: '📚',
        type: TargetType.reading,
        targetValue: 30,
        unit: 'minutes',
        color: const Color(0xFF10B981),
        createdAt: DateTime.now(),
      ),
      TargetModel(
        id: 'template_sleep',
        title: 'Sleep Duration',
        emoji: '😴',
        type: TargetType.sleep,
        targetValue: 8,
        unit: 'hours',
        color: const Color(0xFF6366F1),
        createdAt: DateTime.now(),
      ),
    ];
  }
}
