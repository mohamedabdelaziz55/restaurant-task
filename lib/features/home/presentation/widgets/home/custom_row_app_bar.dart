import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/core/routes/app_route.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../main.dart';


class CostomRowAppBar extends StatelessWidget {
  const CostomRowAppBar({super.key, required this.name});
final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Hello ",
              style: Styles.textStyle20bold.copyWith(color: AppColors.pColor),
            ),
            Text("$name, ", style: Styles.textStyle20bold),
          ],
        ),
        GestureDetector(
          onTap: ()async{
           await FirebaseAuth.instance.signOut();
           await sp.clear();
           GoRouter.of(context).pushReplacement(AppRouter.kLogin);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(Icons.output, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
