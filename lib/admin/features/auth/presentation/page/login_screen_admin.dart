import 'package:flutter/material.dart';

import '../widgets/login/login_screen_admin_body.dart';

class LoginScreenAdmin extends StatelessWidget {
  const LoginScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenAdminBody(),
    );
  }
}
