import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed, this.isLoading, required this.name});
  final void Function()? onPressed;
  final bool? isLoading;
  final String name;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading!
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            :  Text(
          name,
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}