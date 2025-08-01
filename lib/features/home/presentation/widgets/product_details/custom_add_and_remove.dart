import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomAddAndRemove extends StatelessWidget {
  const CustomAddAndRemove({super.key, this.onPressed, required this.icon});
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          color: AppColors.pColor,
          borderRadius: BorderRadius.circular(12)
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Center(child:  Icon(icon, size: 16,color: AppColors.white,)),
      ),
    );
  }
}
