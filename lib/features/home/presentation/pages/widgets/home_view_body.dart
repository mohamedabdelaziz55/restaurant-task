import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/styles.dart';
import '../../../../../core/utils/assets.dart';
import 'Custom_list_view_horizontal.dart';
import 'custom_food_icon.dart';
import 'custom_list_view_vertical.dart';
import 'custom_row_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CostomRowAppBar(),
              Text("Deilcious Food", style: Styles.textStyle24bold),
              Text(
                "Discover and Get Great Food",
                style: Styles.textStyle12bold.copyWith(color: AppColors.gray),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FoodIcon(imagePath: AssetsData.iceCream),
                  FoodIcon(imagePath: AssetsData.pizza),
                  FoodIcon(imagePath: AssetsData.salad),
                  FoodIcon(imagePath: AssetsData.burger),
                ],
              ),
              CustomListViewHorizontal(),
              CustomListViewVertical(),
              CustomListViewVertical(),
            ],
          ),
        ),
      ),
    );
  }
}
