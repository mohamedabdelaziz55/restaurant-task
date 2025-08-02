import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/utils/assets.dart';
import 'package:res_task/features/auth/presentation/river_pod/login_river_pod/login_river_pod.dart';

import '../../../../../../core/routes/app_route.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../features/auth/presentation/widgets/login/custom_button.dart';
import '../../../../../../features/auth/presentation/widgets/login/login_body.dart';
import '../../../../../../features/auth/presentation/widgets/sign_up/custom_text_field.dart';
import '../../river_pod/login_river_pod.dart';


class LoginScreenAdminBody extends ConsumerStatefulWidget {
  const LoginScreenAdminBody({super.key});

  @override
  ConsumerState<LoginScreenAdminBody> createState() =>
      _LoginScreenAdminBodyState();
}

class _LoginScreenAdminBodyState extends ConsumerState<LoginScreenAdminBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(loginAdminProvider.notifier)
        .login(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(loginProvider);

    return Stack(
      children: [
        ClipPath(
          clipper: TopWaveClipper(),
          child: Container(
            height: size.height * 0.55,
            width: size.width,
            color: AppColors.pColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150.0),
              child: Center(child: Image.asset(AssetsData.logo, height: 65)),
            ),
          ),
        ),

        // White Card
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(child: Text("Login", style: Styles.textStyle20bold)),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hint: "Email",
                        icon: Icons.email,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hint: "Password",
                        icon: Icons.lock,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        name: "Login",
                        onPressed: isLoading ? null : _handleLogin,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}
