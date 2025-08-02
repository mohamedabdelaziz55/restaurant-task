import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:res_task/core/%20data/service/shared_pref.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/assets.dart';
import 'package:res_task/core/utils/styles.dart';
import 'package:res_task/core/constants/constants.dart';
import '../../../../core/ data/service/database_dart.dart';
import '../../../../core/utils/custom_snack_bar.dart';

class WalletPageBody extends StatefulWidget {
  const WalletPageBody({super.key});

  @override
  State<WalletPageBody> createState() => _WalletPageBodyState();
}

class _WalletPageBodyState extends State<WalletPageBody> {
  String? wallet;
  double walletBalance = 0;
  double selectedAmount = 0;
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    loadWalletBalance();
    Stripe.publishableKey = publisab;
    Stripe.instance.applySettings();
  }

  Future<void> loadWalletBalance() async {
    final walletStr = await SharedPrefHelper().getUserWallet();
    wallet = walletStr;
    walletBalance = double.tryParse(walletStr ?? '0') ?? 0;
    setState(() {});
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, 'usd');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'ResTask App',
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      print('exception: $e');
      CustomSnackBar.show(
        context,
        message: 'Payment Failed: $e',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        icon: Icons.error_outline,
      );
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        walletBalance += selectedAmount;
        selectedAmount = 0;
      });

      final walletValue = walletBalance.toStringAsFixed(0);

      await SharedPrefHelper().saveUserWallet(walletValue);

      final userId = await SharedPrefHelper().getUserId();
      if (userId != null && userId.isNotEmpty) {
        await DatabaseMethods().upDataUserWallet(userId, walletValue);
      }

      CustomSnackBar.show(
        context,
        message: "Payment Successful",
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
        icon: Icons.check_circle_outline,
      );
    } catch (e) {
      print("Error in payment sheet: $e");
      if (e is StripeException) {
        CustomSnackBar.show(
          context,
          message: "Payment Canceled",
          backgroundColor: Colors.red.shade900,
          colorText: Colors.orange.shade900,
          icon: Icons.info_outline,
        );
      } else {
        CustomSnackBar.show(
          context,
          message: "Payment Failed",
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          icon: Icons.error_outline,
        );
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      final response = await http.post(
        url,
        body: {
          'amount': (int.parse(amount) * 100).toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
        headers: {
          'Authorization': 'Bearer $secret',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception('Error creating payment intent: $err');
    }
  }

  void _navigateToAddCard() async {
    double amountToPay = selectedAmount;

    if (amountToPay == 0) {
      final customAmount = await showDialog<double>(
        context: context,
        builder: (context) => const CustomAmountDialog(),
      );

      if (customAmount == null || customAmount <= 0) {
        CustomSnackBar.show(
          context,
          message: 'You must enter a valid amount',
          backgroundColor: Colors.amber.shade100,
          colorText: Colors.amber.shade900,
          icon: Icons.warning_amber_outlined,
        );
        return;
      }

      amountToPay = customAmount;
      selectedAmount = amountToPay;
    }

    await makePayment(amountToPay.toStringAsFixed(0));
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
                      '\$${walletBalance.toStringAsFixed(2)}',
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
                selectedColor: AppColors.pColor,
                labelStyle: TextStyle(
                  color: selectedAmount == amount ? Colors.white : Colors.black,
                ),
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
class CustomAmountDialog extends StatefulWidget {
  const CustomAmountDialog({super.key});

  @override
  State<CustomAmountDialog> createState() => _CustomAmountDialogState();
}

class _CustomAmountDialogState extends State<CustomAmountDialog> {
  final TextEditingController _controller = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Amount',style: TextStyle(color: AppColors.pColor)),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter Amount',
          errorText: error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final value = _controller.text.trim();
            final parsed = double.tryParse(value);
            if (parsed == null || parsed <= 0) {
              setState(() {
                error = 'Enter valid amount';
              });
              return;
            }
            GoRouter.of(context).pop(parsed);
          },
          child:  Text('Confirm', style: TextStyle(color: AppColors.black),),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel',style: TextStyle(color: AppColors.pColor)),
        ),
      ],
    );
  }
}