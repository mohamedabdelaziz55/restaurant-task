import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your email',
            style: TextStyle(fontSize: 18.0),
          ),
        ),

      );
      print(email);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password Reset Email has been sent!',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No user found for that email.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.message}',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.08),
              Text(
                "Password Recovery",
                style: Styles.textStyle24bold.copyWith(color: AppColors.black),
              ),
              SizedBox(height: height * 0.01),
              Text(
                "Enter your mail",
                style: Styles.textStyle16.copyWith(color: AppColors.grey),
              ),
              SizedBox(height: height * 0.05),
              CustomEmailTextField(controller: emailController),
              SizedBox(height: height * 0.03),
              CustomResetButton(onPressed: resetPassword),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kSignUp);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: Styles.textStyle14.copyWith(color: AppColors.grey),
                      children: [
                        TextSpan(
                          text: "Create",
                          style: Styles.textStyle14bold.copyWith(
                            color: AppColors.pColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomEmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomEmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.pColor,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(Icons.email, color: AppColors.pColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.pColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pColor),
        ),
      ),
      style: Styles.textStyle16.copyWith(color: AppColors.black),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class CustomResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Send Email',
          style: Styles.textStyle16bold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
