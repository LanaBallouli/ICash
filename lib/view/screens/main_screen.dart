import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:test_sales/view/screens/home_screen.dart';
import 'package:test_sales/view/screens/management_screen.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: pages[activeIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.manage_accounts_outlined,
          Icons.analytics_outlined,
          Icons.settings_outlined,
        ],
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        activeColor: Colors.black,
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
        onPressed: () {},
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
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/map.png'),
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(Icons.map_outlined, size: 30),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
