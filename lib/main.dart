import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/constants/constants.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/styles.dart';

import 'core/routes/app_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: kFont),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}





