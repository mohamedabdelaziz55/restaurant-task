import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/app_colors.dart';

import '../../../../../core/utils/styles.dart';
import '../../river_pod/sign_up_river_pod/sing_up_river_pod.dart';
import '../sign_up/custom_text_field.dart';

class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({super.key});

  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();}


class _SignUpBodyState extends ConsumerState<SignUpBody> {
  String email = "", password = "", name = "";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void handleSignUp() async {
    final signUpController = ref.read(signUpControllerProvider.notifier);
    await signUpController.signUp(
      context: context,
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      formKey: _formKey,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(isSignUpLoadingProvider);
    return Stack(
      children: [
        Image.asset('assets/images/logo.png', height: 65),
        ClipPath(
          clipper: TopWaveClipper(),
          child: Container(
            height: size.height * 0.55,
            width: size.width,
            color: AppColors.pColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150.0),
              child: Center(
                child: Image.asset('assets/images/logo.png', height: 65),
              ),
            ),
          ),
        ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Sign up", style: Styles.textStyle20bold),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hint: "Name",
                      icon: Icons.person,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hint: "Email",
                      icon: Icons.email,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hint: "Password",
                      icon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            handleSignUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                            : const Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 28,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?", style: Styles.textStyle14),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLogin);
                },
                child: Text('Login', style: TextStyle(color: AppColors.pColor)),
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
