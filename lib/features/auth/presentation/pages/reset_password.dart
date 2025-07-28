
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import '../../../../core/utils/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../river_pod/reset_password/reset_password_river_pod.dart';
import '../widgets/reset_pass/custom_email_text_field.dart';
import '../widgets/reset_pass/custom_reset_button.dart';


class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final resetState = ref.watch(resetPasswordProvider);

    ref.listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          CustomSnackBar.show(
            context,
            colorText: Colors.white,
            message: 'Password Reset Email has been sent!',
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
        },
        error: (err, _) {
          CustomSnackBar.show(
            context,
            colorText: Colors.white,
            message: err.toString(),
            backgroundColor: Colors.red,
            icon: Icons.error,
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






