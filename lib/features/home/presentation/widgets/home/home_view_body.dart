import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/styles.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../main.dart';
import 'Custom_list_view_horizontal.dart';
import 'custom_food_icon.dart';
import 'custom_list_view_vertical.dart';
import 'custom_row_app_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? name;
  int selectedIndex = -1;
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
  final List<String> icons = [
    AssetsData.iceCream,
    AssetsData.pizza,
    AssetsData.salad,
    AssetsData.burger,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CostomRowAppBar(name:name ?? 'No Name' ,),
              Text("Deilcious Food", style: Styles.textStyle24bold),
              Text(
                "Discover and Get Great Food",
                style: Styles.textStyle12bold.copyWith(color: AppColors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(icons.length, (index) {
                  return FoodIcon(
                    imagePath: icons[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
              ),
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

class CustomIconView extends StatelessWidget {
  const CustomIconView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
