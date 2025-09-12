import 'package:flutter/material.dart';
import '../models/health_data.dart';
import '../models/target_model.dart';
import '../../../core/services/health_service.dart';

class HealthViewModel extends ChangeNotifier {
  List<HealthData> _healthData = [];
  List<ActivityData> _activities = [];
  final List<GoalData> _goals = [
    GoalData(name: 'Glasses', days: ['S', 'M', 'T', 'W', 'T', 'F', 'S']),
  ];
  List<TargetModel> _targets = [];
  List<double> _weeklyProgress = [];

  bool _isLoading = false;

  List<HealthData> get healthData => _healthData;
  List<ActivityData> get activities => _activities;
  List<GoalData> get goals => _goals;
  List<TargetModel> get targets => _targets;
  List<double> get weeklyProgress => _weeklyProgress;
  bool get isLoading => _isLoading;

  int get todayWater {
    final waterTarget = _targets.firstWhere(
      (target) => target.type == TargetType.water,
      orElse: () => TargetModel(
        id: 'default',
        title: 'Water',
        emoji: '💧',
        type: TargetType.water,
        targetValue: 8,
        currentValue: 0,
        unit: 'glasses',
        color: const Color(0xFF06B6D4),
        createdAt: DateTime.now(),
      ),
    );
    return waterTarget.currentValue.toInt();
  }

  int get waterGoal {
    final waterTarget = _targets.firstWhere(
      (target) => target.type == TargetType.water,
      orElse: () => TargetModel(
        id: 'default',
        title: 'Water',
        emoji: '💧',
        type: TargetType.water,
        targetValue: 8,
        unit: 'glasses',
        color: const Color(0xFF06B6D4),
        createdAt: DateTime.now(),
      ),
    );
    return waterTarget.targetValue.toInt();
  }

  int get todaySteps {
    final stepsTarget = _targets.firstWhere(
      (target) => target.type == TargetType.steps,
      orElse: () => TargetModel(
        id: 'default',
        title: 'Steps',
        emoji: '👟',
        type: TargetType.steps,
        targetValue: 10000,
        currentValue: 0,
        unit: 'steps',
        color: const Color(0xFFF59E0B),
        createdAt: DateTime.now(),
      ),
    );
    return stepsTarget.currentValue.toInt();
  }

  int get stepsGoal {
    final stepsTarget = _targets.firstWhere(
      (target) => target.type == TargetType.steps,
      orElse: () => TargetModel(
        id: 'default',
        title: 'Steps',
        emoji: '👟',
        type: TargetType.steps,
        targetValue: 10000,
        unit: 'steps',
        color: const Color(0xFFF59E0B),
        createdAt: DateTime.now(),
      ),
    );
    return stepsTarget.targetValue.toInt();
  }

  HealthViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        HealthService.getHealthData(),
        HealthService.getActivities(),
        HealthService.getWeeklyProgress(),
      ]);

      _healthData = results[0] as List<HealthData>;
      _activities = results[1] as List<ActivityData>;
      _weeklyProgress = results[2] as List<double>;
      
      _targets = TargetModel.getDefaultTargets();
    } catch (e) {
      debugPrint('Error loading health data: $e');
      _loadDefaultData();
    }

    _isLoading = false;
    notifyListeners();
  }

  void _loadDefaultData() {
    _healthData = [
      HealthData(
        title: 'Drinking water',
        percentage: 75,
        icon: '💧',
        color: const Color(0xFF06B6D4),
      ),
      HealthData(
        title: 'Cycling',
        percentage: 40,
        icon: '🚴',
        color: const Color(0xFFF59E0B),
      ),
      HealthData(
        title: 'Water',
        percentage: 40,
        icon: '💧',
        color: const Color(0xFF8B5CF6),
      ),
      HealthData(
        title: 'Walking',
        percentage: 40,
        icon: '🚶',
        color: const Color(0xFF10B981),
      ),
    ];

    _activities = [
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

    _weeklyProgress = [0.6, 0.8, 0.7, 0.9, 0.5, 0.4, 0.8];
    _targets = TargetModel.getDefaultTargets();
  }

  Future<void> refreshData() async {
    await _loadData();
  }

  void updateGoal(int index, bool selected) {
    if (index >= 0 && index < _goals.length) {
      _goals[index].isSelected = selected;
      notifyListeners();
    }
  }


  void addActivity(String name, String time) {
    _activities.insert(0, ActivityData(
      name: name,
      time: time,
      avatar: '👤',
    ));
    notifyListeners();
  }

  void addTarget(TargetModel target) {
    final newTarget = target.copyWith(
      id: target.id.isEmpty ? 'target_${DateTime.now().millisecondsSinceEpoch}' : target.id,
      createdAt: DateTime.now(),
    );
    
    _targets.add(newTarget);
    
    // Add activity for target creation
    addActivity(
      'Created new target: ${newTarget.title}',
      'Just now',
    );
    _updateWeeklyProgressFromTargets();
    
    notifyListeners();
  }

  void updateTargetProgress(String targetId, double newValue) {
    final targetIndex = _targets.indexWhere((target) => target.id == targetId);
    if (targetIndex != -1) {
      final oldTarget = _targets[targetIndex];
      final updatedTarget = oldTarget.copyWith(
        currentValue: newValue,
        isCompleted: newValue >= oldTarget.targetValue,
        completedAt: newValue >= oldTarget.targetValue ? DateTime.now() : null,
      );
      
      _targets[targetIndex] = updatedTarget;
      
      addActivity(
        updatedTarget.activityDescription,
        'Just now',
      );
      
      // Update weekly progress
      _updateWeeklyProgressFromTargets();
      
      notifyListeners();
    }
  }

  void incrementTargetProgress(String targetId, [double increment = 1.0]) {
    final target = _targets.firstWhere(
      (target) => target.id == targetId,
      orElse: () => throw Exception('Target not found'),
    );
    
    final newValue = (target.currentValue + increment).clamp(0.0, target.targetValue);
    updateTargetProgress(targetId, newValue);
  }

  void decrementTargetProgress(String targetId, [double decrement = 1.0]) {
    final target = _targets.firstWhere(
      (target) => target.id == targetId,
      orElse: () => throw Exception('Target not found'),
    );
    
    final newValue = (target.currentValue - decrement).clamp(0.0, target.targetValue);
    updateTargetProgress(targetId, newValue);
  }

  void removeTarget(String targetId) {
    final targetIndex = _targets.indexWhere((target) => target.id == targetId);
    if (targetIndex != -1) {
      final removedTarget = _targets[targetIndex];
      _targets.removeAt(targetIndex);
      
      addActivity(
        'Removed target: ${removedTarget.title}',
        'Just now',
      );
      
      _updateWeeklyProgressFromTargets();
      notifyListeners();
    }
  }

  void completeTarget(String targetId) {
    final targetIndex = _targets.indexWhere((target) => target.id == targetId);
    if (targetIndex != -1) {
      final target = _targets[targetIndex];
      _targets[targetIndex] = target.copyWith(
        currentValue: target.targetValue,
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      
      addActivity(
        'Completed target: ${target.title}! 🎉',
        'Just now',
      );
      
      _updateWeeklyProgressFromTargets();
      notifyListeners();
    }
  }

  void resetTarget(String targetId) {
    final targetIndex = _targets.indexWhere((target) => target.id == targetId);
    if (targetIndex != -1) {
      final target = _targets[targetIndex];
      _targets[targetIndex] = target.copyWith(
        currentValue: 0.0,
        isCompleted: false,
        completedAt: null,
      );
      
      // Add activity for target reset
      addActivity(
        'Reset target: ${target.title}',
        'Just now',
      );
      
      _updateWeeklyProgressFromTargets();
      notifyListeners();
    }
  }

  void _updateWeeklyProgressFromTargets() {
    if (_targets.isEmpty) {
      _weeklyProgress = [0.6, 0.8, 0.7, 0.9, 0.5, 0.4, 0.8];
      return;
    }
    
    final averageProgress = _targets.fold<double>(
      0.0,
      (sum, target) => sum + (target.progressPercentage / 100),
    ) / _targets.length;
    
    _weeklyProgress = List.generate(7, (index) {
      final variance = (index - 3) * 0.1; // Add some variance
      return (averageProgress + variance).clamp(0.0, 1.0);
    });
  }

  void incrementWater() {
    try {
      final waterTarget = _targets.firstWhere((target) => target.type == TargetType.water);
      incrementTargetProgress(waterTarget.id);
    } catch (e) {
      final waterTarget = TargetModel(
        id: 'water_default',
        title: 'Water Intake',
        emoji: '💧',
        type: TargetType.water,
        targetValue: 8,
        currentValue: 1,
        unit: 'glasses',
        color: const Color(0xFF06B6D4),
        createdAt: DateTime.now(),
      );
      addTarget(waterTarget);
    }
  }

  void decrementWater() {
    try {
      final waterTarget = _targets.firstWhere((target) => target.type == TargetType.water);
      decrementTargetProgress(waterTarget.id);
    } catch (e) {
    }
  }

  List<TargetModel> getAvailableTargetTemplates() {
    return TargetModel.getAvailableTargetTemplates();
  }

  int get completedTargetsToday {
    return _targets.where((target) => target.isCompleted).length;
  }

  int get totalTargets {
    return _targets.length;
  }

  double get overallProgress {
    if (_targets.isEmpty) return 0.0;
    return _targets.fold<double>(
      0.0,
      (sum, target) => sum + target.progressPercentage,
    ) / _targets.length;
  }
}
