import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/home_model/product_model.dart';
import 'custom_add_and_remove.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductInfo({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.title, style: Styles.textStyle24bold.copyWith(color: AppColors.pColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAddAndRemove(
                    icon: Icons.remove,
                    onPressed: onDecrement,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text('$quantity', style: Styles.textStyle16bold),
                  ),
                  CustomAddAndRemove(icon: Icons.add, onPressed: onIncrement),
                ],
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Text(
            product.description,
            style: Styles.textStyle14.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: width * 0.04),
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 20,
                color: AppColors.pColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Delivery Time: ${product.deliveryTime}',
                style: Styles.textStyle14,
              ),
            ],
          ),
          SizedBox(height: width * 0.05),
        ],
      ),
    );
  }
}
