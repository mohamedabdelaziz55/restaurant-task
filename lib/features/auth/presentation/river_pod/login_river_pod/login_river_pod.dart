import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/custom_snack_bar.dart';
import '../../../../../main.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      CustomSnackBar.show(
        context,
        message: 'Please fill in all fields',
        backgroundColor: Colors.orange,
        icon: Icons.warning_amber_outlined,
        colorText: Colors.white,
      );
      return;
    }

    try {
      state = true;

      UserCredential response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      state = false;

      final user = response.user;

      if (user != null) {
        await sp.setString('user_id', user.uid);
        await sp.setString('user_email', user.email ?? '');
        await sp.setString('display_name', user.displayName ?? '');
      }

      CustomSnackBar.show(
        context,
        message: 'Login successful!',
        backgroundColor: Colors.green,
        icon: Icons.check_circle_outline,
        colorText: Colors.white,
      );

      GoRouter.of(context).pushReplacement(AppRouter.kDashboard);
    } catch (e) {
      state = false;
      CustomSnackBar.show(
        context,
        message: 'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        icon: Icons.error_outline,
        colorText: Colors.white,
      );
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      default:
        return e.message ?? 'Login failed';
    }
  }
}
