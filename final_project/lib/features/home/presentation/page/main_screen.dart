import 'package:final_project/features/favorites/presentation/page/favorites_screen.dart';
import 'package:final_project/features/cart/presentation/page/cart_screen.dart';
import 'package:final_project/features/home/presentation/page/home_screen.dart';
import 'package:final_project/features/home/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:final_project/features/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedNavIndex = 0;

  void _onNavTap(int index) => setState(() => _selectedNavIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          IndexedStack(
            index: _selectedNavIndex,
            sizing: StackFit.expand,
            children: [
              const FashionHomeScreen(),
              FavoritesScreen(onBack: () => _onNavTap(0)),
              CartScreen(onBack: () => _onNavTap(0)),
              ProfileScreen(onBack: () => _onNavTap(0)),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: AppBottomNavBar(
              selectedIndex: _selectedNavIndex,
              onTap: _onNavTap,
            ),
          ),
        ],
      ),
    );
  }
}
