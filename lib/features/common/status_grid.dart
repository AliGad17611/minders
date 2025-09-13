import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/dashboard/models/status_model.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key, required this.stats});
  final List<StatModel> stats;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: .77,
      padding: EdgeInsets.only(left: 16, right: 16, top: 50),
      crossAxisSpacing: 16,
      mainAxisSpacing: 20,
      children: stats.map((stat) => StatContainer(stat: stat)).toList(),
    );
  }
}

class StatContainer extends StatelessWidget {
  const StatContainer({super.key, required this.stat});
  final StatModel stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteTextColors,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Center(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.purpleMain.withValues(alpha: .5),
                  width: 6,
                ),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(stat.icon),
            ),
          ),
          SizedBox(height: 20),
          Text(stat.title, style: AppTextStyles.text20w400Purple),
          Text(stat.value, style: AppTextStyles.text20w400Purple),
        ],
      ),
    );
  }
}