import 'package:flutter/material.dart';
import 'package:minders/features/dashboard/viewmodels/navigation_viewmodel.dart';
import 'package:minders/features/dashboard/views/screens/dashboard_home.dart';
import 'package:minders/features/dashboard/views/widgets/dashboard_screen.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, navigationModel, child) {
        return Scaffold(
          body: IndexedStack(
            index: navigationModel.currentIndex,
            children: const [
              DashboardHome(),
              DashboardScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: navigationModel.currentIndex,
              onTap: navigationModel.setCurrentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.purpleMain,
              unselectedItemColor: AppColors.tertiaryTextColors,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_rounded),
                  activeIcon: Icon(Icons.analytics_rounded),
                  label: 'Progress',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
