import 'package:flutter/material.dart';
import '../widgets/login/login_body.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: LoginBody(),
    );
  }
}
