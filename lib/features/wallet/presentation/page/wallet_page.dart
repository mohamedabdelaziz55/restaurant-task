import 'package:flutter/material.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/features/wallet/presentation/widgets/wallet_page_body.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet', style: TextStyle(color: AppColors.pColor)),
        centerTitle: true,
      ),
      body: WalletPageBody(),
    );
  }
}
