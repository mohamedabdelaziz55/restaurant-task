import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/styles.dart';

import '../../../../../core/routes/app_route.dart';
import '../../../../../main.dart';

class HomeAdminBody extends StatelessWidget {
  const HomeAdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: Styles.textStyle24bold.copyWith(color: AppColors.pColor),
              ),
              Text(" Admin,", style: Styles.textStyle24bold),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  "Confirm Logout",
                  style: TextStyle(color: AppColors.pColor),
                ),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.pColor),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            );

            if (shouldLogout == true) {
              await FirebaseAuth.instance.signOut();
              await sp.clear();
              GoRouter.of(context).pushReplacement(AppRouter.kLogin);
            }
          },
          icon: Icon(Icons.output),
        ),

      ],
    );
  }
}
