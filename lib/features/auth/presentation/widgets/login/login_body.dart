import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/utils/assets.dart';

import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../sign_up/custom_text_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 final GlobalKey _formKay= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              child: Center(
                child: Image.asset(AssetsData.logo, height: 65),
              ),
            ),
          ),
        ),

        // White Card
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: Text("Login", style: Styles.textStyle20bold)),
                  const SizedBox(height: 16),
                  CustomTextField(hint: "Email", icon: Icons.email),
                  const SizedBox(height: 12),
                  CustomTextField(hint: "Password", icon: Icons.lock),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("ForGet password?"),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacement(AppRouter.kDashboard);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bottom Text
        Positioned(
          bottom: 28,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?", style: Styles.textStyle14),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kSignUp);
                },
                child: Text('SignUp', style: TextStyle(color: AppColors.pColor),),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.5,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
