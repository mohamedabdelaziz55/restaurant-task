import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:res_task/core/utils/app_colors.dart';
import '../../../../../features/home/presentation/pages/home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.i});

  final int? i;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    const HomePage(),
    const FavoritesPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.i != null) {
      index = widget.i!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(
        Icons.home_outlined,
        size: 30,
        color: index == 0 ? AppColors.white : AppColors.grey,
      ),
      Icon(
        Icons.favorite_border,
        size: 30,
        color: index == 1 ? AppColors.white : AppColors.grey,
      ),
      Icon(
        Icons.shopping_cart_outlined,
        size: 30,
        color: index == 2 ? AppColors.white : AppColors.grey,
      ),
      Icon(
        Icons.person,
        size: 30,
        color: index == 3 ? AppColors.white : AppColors.grey,
      ),
    ];

    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: CurvedNavigationBar(
            key: navigationKey,
            backgroundColor: Colors.transparent,
            color: Colors.white,
            buttonBackgroundColor: AppColors.pColor,
            height: 70,
            index: index,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
        body: screens[index],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hi")));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hi")));
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hi")));
  }
}
