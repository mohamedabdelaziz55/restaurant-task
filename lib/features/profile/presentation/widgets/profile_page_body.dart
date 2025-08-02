import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:res_task/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:res_task/features/profile/presentation/widgets/profile_info_tile.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../main.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}


class _ProfilePageBodyState extends State<ProfilePageBody> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {

    setState(() {
      name = sp.getString('display_name') ?? 'No Name';
      email = sp.getString('user_email') ?? 'No Email';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 40,),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text("Hi $name," ?? '', style: Styles.textStyle24bold.copyWith(color: Colors.white)),
                const SizedBox(height: 100),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        ProfileInfoTile(
                          icon: Icons.person,
                          title: 'Name',
                          subtitle: name ?? '',
                        ),
                        const SizedBox(height: 12),
                        ProfileInfoTile(
                          icon: Icons.email,
                          title: 'Email',
                          subtitle: email ?? '',
                        ),
                        const SizedBox(height: 12),
                        ProfileActionTile(
                          text: 'Terms and Condition',
                          icon: Icons.description,
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        ProfileActionTile(
                          text: 'Delete Account',
                          icon: Icons.delete,
                          iconColor: AppColors.errorRed,
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        ProfileActionTile(
                          text: 'LogOut',
                          icon: Icons.logout,
                          iconColor: AppColors.black,
                          onTap: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Confirm Logout" ,style: TextStyle(color: AppColors.pColor) ),
                                content: const Text("Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text("Cancel",style: TextStyle(color: AppColors.pColor),),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.pColor,
                                    ),
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text("Logout",style: TextStyle(color: AppColors.white)),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


