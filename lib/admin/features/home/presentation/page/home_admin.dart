import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/routes/app_route.dart';
import 'package:res_task/core/utils/app_colors.dart';

import '../widgets/home_admin_body.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pColor,
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kAddProduct);
        },
        child: Icon(Icons.add, color: AppColors.white),
      ),
      body: HomeAdminBody(),
    );
  }
}
