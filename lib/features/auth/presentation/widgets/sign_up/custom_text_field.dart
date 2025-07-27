import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText; // useful for password

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hint';
            }
            return null;
          },
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.grey),
      ),
    );
  }
}
