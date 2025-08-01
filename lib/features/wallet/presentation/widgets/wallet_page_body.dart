import 'package:flutter/material.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/assets.dart';
import 'package:res_task/core/utils/styles.dart';

class WalletPageBody extends StatefulWidget {
  const WalletPageBody({super.key});

  @override
  State<WalletPageBody> createState() => _WalletPageBodyState();
}

class _WalletPageBodyState extends State<WalletPageBody> {
  double walletBalance = 150;
  double selectedAmount = 0;

  void _navigateToAddCard() {
    if (selectedAmount == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an amount')));
      return;
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => AddCardScreen(
    //       amount: selectedAmount,
    //       onPaymentSuccess: (newAmount) {
    //         setState(() {
    //           walletBalance += newAmount;
    //         });
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final amounts = [100, 500, 1000, 2000];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(AssetsData.wallet, height: 60),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Wallet', style: TextStyle(fontSize: 16)),
                    Text(
                      '\$${walletBalance.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add money',
              style: Styles.textStyle18.copyWith(color: AppColors.pColor),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            children: amounts.map((amount) {
              return ChoiceChip(
                label: Text('\$$amount'),
                selected: selectedAmount == amount,
                onSelected: (_) {
                  setState(() {
                    selectedAmount = amount.toDouble();
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _navigateToAddCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Add Money',
                style: Styles.textStyle18.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
