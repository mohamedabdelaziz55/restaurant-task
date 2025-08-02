import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ProfileActionTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const ProfileActionTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.pColor),
            const SizedBox(width: 12),
            Text(text, style: Styles.textStyle16bold),
          ],
        ),
      ),
    );
  }
}