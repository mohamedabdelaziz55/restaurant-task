import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const CustomTextField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.gray),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}