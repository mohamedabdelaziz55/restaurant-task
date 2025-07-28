import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/custom_snack_bar.dart';
import '../../../../../main.dart';

final isSignUpLoadingProvider = StateProvider<bool>((ref) => false);

final signUpControllerProvider = NotifierProvider<SignUpController, void>(
  SignUpController.new,
);

class SignUpController extends Notifier<void> {
  @override
  void build() {}

  String getPasswordStrength(String password) {
    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasLower = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'\d'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.length < 6) {
      return "Weak";
    } else if ((hasLower && hasDigit) && password.length >= 6) {
      return "Medium";
    } else if (hasUpper &&
        hasLower &&
        hasDigit &&
        hasSpecial &&
        password.length >= 8) {
      return "Strong";
    } else {
      return "Weak";
    }
  }

  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
    required GlobalKey<FormState> formKey,
  }) async {
    final loading = ref.read(isSignUpLoadingProvider.notifier);
    loading.state = true;

    email = email.trim();
    password = password.trim();
    name = name.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      loading.state = false;
      CustomSnackBar.show(
        context,
        message: "Please fill in all fields",
        backgroundColor: Colors.red,
        icon: Icons.warning_amber_rounded,
        colorText: Colors.white,
      );
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      loading.state = false;
      CustomSnackBar.show(
        context,
        message: "Please enter a valid email address",
        backgroundColor: Colors.red,
        icon: Icons.email_outlined,
        colorText: Colors.white,
      );
      return;
    }

    String passwordStrength = getPasswordStrength(password);
    if (passwordStrength == "Weak") {
      loading.state = false;
      CustomSnackBar.show(
        context,
        message:
            "Password is too weak. Use uppercase, numbers, and special characters",
        backgroundColor: Colors.red,
        icon: Icons.lock_outline,
        colorText: Colors.white,
      );
      return;
    }

    try {
      UserCredential response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await response.user?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.reload();

      final currentUser = FirebaseAuth.instance.currentUser;

      await sp.setString('user_id', currentUser?.uid ?? '');
      await sp.setString('user_email', currentUser?.email ?? '');
      await sp.setString('display_name', currentUser?.displayName ?? '');

      loading.state = false;

      Future.delayed(const Duration(milliseconds: 600), () {
        GoRouter.of(context).pushReplacement(AppRouter.kDashboard);
      });
    } catch (e) {
      loading.state = false;
      CustomSnackBar.show(
        context,
        message: "Failed to create account: $e",
        backgroundColor: Colors.red,
        icon: Icons.error_outline,
        colorText: Colors.white,
      );
    }
  }
}
