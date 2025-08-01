import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final resetPasswordProvider =
StateNotifierProvider<ResetPasswordNotifier, AsyncValue<void>>(
      (ref) => ResetPasswordNotifier(),
);

class ResetPasswordNotifier extends StateNotifier<AsyncValue<void>> {
  ResetPasswordNotifier() : super(const AsyncData(null));

  Future<void> sendResetPasswordEmail(String email) async {
    if (email.isEmpty) {
      state = const AsyncError('Please enter your email', StackTrace.empty);
      return;
    }

    state = const AsyncLoading();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      state = const AsyncData(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = const AsyncError(
          'No user found for that email.',
          StackTrace.empty,
        );
      } else {
        state = AsyncError(e.message ?? 'Something went wrong.', StackTrace.empty);
      }
    }
  }
}
