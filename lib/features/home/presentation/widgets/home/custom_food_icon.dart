import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class FoodIcon extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const FoodIcon({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.pColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 6, offset: Offset(3, 3)),
            BoxShadow(color: Colors.white, blurRadius: 6, offset: Offset(-3, -3)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            imagePath,
            color: isSelected ? Colors.white : AppColors.pColor,
          ),
        ),
      ),
    );
  }
}
