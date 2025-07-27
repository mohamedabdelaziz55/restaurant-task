import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';


class CostomRowAppBar extends StatelessWidget {
  const CostomRowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Hello ",
              style: Styles.textStyle20bold.copyWith(color: AppColors.pColor),
            ),
            Text("Mohamed, ", style: Styles.textStyle20bold),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.pColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.shopping_cart_outlined, color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
