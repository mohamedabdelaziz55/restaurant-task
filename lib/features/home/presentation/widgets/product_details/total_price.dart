import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';

class TotalPrice extends StatelessWidget {
  final String price;
  final int quantity;

  const TotalPrice({super.key, required this.price, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final total = (double.tryParse(price) ?? 0.0) * quantity;

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
      child: Row(
        children: [
          Text(
            'Total Price',
            style: Styles.textStyle16.copyWith(color: AppColors.pColor),
          ),
          const Spacer(),
          Text('\$${total.toStringAsFixed(2)}', style: Styles.textStyle18bold),
          SizedBox(width: width * 0.04),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pColor,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.white,
            ),
            label: const Text(
              'Add to cart',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
