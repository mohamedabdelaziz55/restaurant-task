// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../../../../../main.dart';
//
// final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
//   return LoginNotifier();
// });
//
// class LoginNotifier extends StateNotifier<bool> {
//   LoginNotifier() : super(false);
//
//   final supabase = Supabase.instance.client;
//
//   Future<String?> login({
//     required String email,
//     required String password,
//   }) async {
//     if (state) return null;
//     state = true;
//
//     try {
//       final response = await supabase.auth.signInWithPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       if (response.session != null && response.user != null) {
//         final user = response.user!;
//
//         await sp.setString('user_id', user.id);
//         await sp.setString('user_email', user.email ?? '');
//         final name = user.userMetadata?['display_name'] ?? '';
//         await sp.setString('display_name', name);
//
//         return null;
//       } else {
//         return 'Login failed. Please check credentials.';
//       }
//     } catch (e) {
//       return e.toString();
//     } finally {
//       state = false;
//     }
//   }
// }
