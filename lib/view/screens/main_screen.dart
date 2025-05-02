import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_sales/app_constants.dart';
import 'package:test_sales/view/screens/home_screens/home_screen.dart';
import 'package:test_sales/view/screens/management_screens/management_screen.dart';
import 'package:test_sales/view/screens/map_screen.dart';
import 'package:test_sales/view/screens/reports_screen.dart';
import 'package:test_sales/view/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int activeIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const ManagementScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
    const MapScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 0),
      body: pages[activeIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: AppConstants.buttonColor,
        borderColor: AppConstants.buttonColor,
        borderWidth: 2.w,
        icons: const [
          Icons.home_outlined,
          Icons.manage_accounts_outlined,
          Icons.analytics_outlined,
          Icons.settings_outlined,
        ],
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        activeColor: AppConstants.primaryColor2,
        inactiveColor: Colors.black45,
        notchSmoothness: NotchSmoothness.softEdge,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "8",
        onPressed: () {
          setState(() {
            activeIndex = 4;
          });
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: AppConstants.primaryColor2,
                radius: 30,
                child: Image.asset("assets/images/google-maps.png", height: 30.h, width: 30.w,),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
