
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';

class CostomRowAppBar extends StatelessWidget {
  const CostomRowAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hello Mohamed",
          style: Styles.textStyle20bold.copyWith(
            fontFamily: kFont,
            color: AppColors.pColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.pColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.shopping_cart_outlined,color: AppColors.white,),
          ),
        ),
      ],
    );
  }
}
