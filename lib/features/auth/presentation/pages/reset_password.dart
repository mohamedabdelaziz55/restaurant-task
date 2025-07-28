
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../river_pod/reset_password/reset_password_river_pod.dart';


class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final resetState = ref.watch(resetPasswordProvider);

    ref.listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Password Reset Email has been sent!',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                err.toString(),
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          );
        },
      );
    });

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
              CustomResetButton(
                onPressed: () {
                  ref
                      .read(resetPasswordProvider.notifier)
                      .sendResetPasswordEmail(emailController.text.trim());
                },
                isLoading: resetState.isLoading,
              ),
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
  final bool isLoading;

  const CustomResetButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : Text(
          'Send Email',
          style: Styles.textStyle16bold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

