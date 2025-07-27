import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/custom_snack_bar.dart';

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
    try {
      state = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      state = false;
      GoRouter.of(context).pushReplacement(AppRouter.kDashboard);
    } on FirebaseAuthException catch (e) {
      state = false;
      CustomSnackBar.show(
        colorText: Colors.white,
        context,
        message: _getErrorMessage(e),
        backgroundColor: Colors.red,
        icon: Icons.email_outlined,
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
