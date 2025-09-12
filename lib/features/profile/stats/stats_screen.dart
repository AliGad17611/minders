import 'package:flutter/material.dart';
import 'package:minders/core/utils/assets/app_icons.dart';
import 'package:minders/features/common/stats_grid.dart';
import 'package:minders/features/models/stat_model.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  get stats => [
        StatModel(title: "Drinking water", value: "75%", icon: AppIcons.water),
        StatModel(title: "Cycling", value: "40%", icon: AppIcons.cycling),
        StatModel(title: "Water", value: "65%", icon: AppIcons.water_drop),
        StatModel(title: "Walking", value: "75%", icon: AppIcons.foot),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(title: Text("All Habits")),
      body: StatsGrid(stats: stats),
    );
  }
}
