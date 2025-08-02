
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_route.dart';



final loginAdminProvider = StateNotifierProvider<LoginAdminNotifier, bool>((ref) {
  return LoginAdminNotifier();
});

class LoginAdminNotifier extends StateNotifier<bool> {
  LoginAdminNotifier() : super(false);

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true; // start loading

    try {
      final enteredId = email.trim();
      final enteredPassword = password.trim();

      final snapshot = await FirebaseFirestore.instance.collection("Admin").get();

      final matchedAdmin = snapshot.docs.firstWhere(
            (doc) => doc['id'] == enteredId,
        orElse: () => null!,
      );

      if (matchedAdmin == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Your id is not correct", style: TextStyle(fontSize: 18.0)),
          ),
        );
        return;
      }

      if (matchedAdmin['password'] != enteredPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Your password is not correct", style: TextStyle(fontSize: 18.0)),
          ),
        );
        return;
      }

      // login success
      GoRouter.of(context).pushReplacement(AppRouter.kHomeAdminPage);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("An error occurred: $e", style: const TextStyle(fontSize: 16.0)),
        ),
      );
    } finally {
      state = false; // end loading
    }
  }
}
