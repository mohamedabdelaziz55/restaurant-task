import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ data/service/database_dart.dart';
import '../../../../core/ data/service/shared_pref.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_snack_bar.dart';
import '../../../../core/utils/styles.dart';
import '../river_pod/cart_river_pod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Quantity
                        Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        // Product Image and Info
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: item.product.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            title: Text(
                              item.product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('\$${item.totalPrice.toStringAsFixed(0)}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },

            ),
          ),
          CartTotalSection()
        ],
      ),
    );
  }
}


class CartTotalSection extends ConsumerWidget {
  const CartTotalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final total = ref.watch(cartProvider.notifier).total;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.04,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: Row(
          children: [
            Text(
              'Total Price',
              style: Styles.textStyle16.copyWith(color: AppColors.pColor),
            ),
            const Spacer(),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: Styles.textStyle18bold,
            ),
            SizedBox(width: width * 0.04),
            ElevatedButton.icon(
              onPressed: () async {
                final walletStr = await SharedPrefHelper().getUserWallet();
                final wallet = double.tryParse(walletStr ?? '0') ?? 0;

                if (wallet < total) {
                  CustomSnackBar.show(
                    context,
                    message: 'Insufficient balance, please recharge your wallet.',
                    backgroundColor: Colors.red.shade100,
                    colorText: Colors.red.shade900,
                    icon: Icons.warning,
                  );
                  return;
                }

                final newBalance = wallet - total;
                await SharedPrefHelper().saveUserWallet(newBalance.toStringAsFixed(0));

                final userId = await SharedPrefHelper().getUserId();
                if (userId != null && userId.isNotEmpty) {
                  await DatabaseMethods().upDataUserWallet(userId, newBalance.toStringAsFixed(0));
                }

                ref.read(cartProvider.notifier).clearCart();

                CustomSnackBar.show(
                  context,
                  message: 'Purchase completed successfully!',
                  backgroundColor: Colors.green.shade100,
                  colorText: Colors.green.shade900,
                  icon: Icons.check_circle_outline,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pColor,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.payment, color: AppColors.white),
              label: const Text(
                'CheckOut',
                style: TextStyle(color: AppColors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
