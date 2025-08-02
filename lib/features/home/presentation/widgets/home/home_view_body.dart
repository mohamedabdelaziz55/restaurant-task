import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/styles.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../main.dart';
import '../../river_pod/products_river_pod.dart';
import 'Custom_list_view_horizontal.dart';
import 'custom_food_icon.dart';
import 'custom_list_view_vertical.dart';

class HomeViewBody extends ConsumerStatefulWidget {
  const HomeViewBody({super.key});

  @override
  ConsumerState<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends ConsumerState<HomeViewBody> {
  String? name;
  int selectedIndex = -1;

  final List<String> icons = [
    AssetsData.iceCream,
    AssetsData.pizza,
    AssetsData.salad,
    AssetsData.burger,
  ];

  final List<String> categories = [
    "Ice-cream",
    "Pizza",
    "Salad",
    "Burger"
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final displayName = sp.getString('display_name');
    setState(() {
      name = displayName;
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
        ref.read(selectedCategoryProvider.notifier).state = null;
      } else {
        selectedIndex = index;
        final selectedCategory = categories[index];
        ref.read(selectedCategoryProvider.notifier).state = selectedCategory;
      }
    });
  }

  void _onShowAllPressed() {
    setState(() {
      selectedIndex = -1;
    });

    ref.read(selectedCategoryProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hello ",
                    style: Styles.textStyle20bold.copyWith(color: AppColors.pColor),
                  ),
                  Text("$name, ", style: Styles.textStyle20bold),
                ],
              ),
              Text("Delicious Food", style: Styles.textStyle24bold),
              Text(
                "Discover and Get Great Food",
                style: Styles.textStyle12bold.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(icons.length, (index) {
                  return FoodIcon(
                    imagePath: icons[index],
                    isSelected: selectedIndex == index,
                    onTap: () => _onCategorySelected(index),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Today's offers",
                  style: Styles.textStyle20bold.copyWith(color: AppColors.grey),
                ),
              ),
              CustomListViewHorizontal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Menu",
                  style: Styles.textStyle20bold.copyWith(color: AppColors.grey),
                ),
              ),
              CustomListViewVertical(),
            ],
          ),
        ),
      ),
    );
  }
}
