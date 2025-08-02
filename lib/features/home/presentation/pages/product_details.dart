import 'package:flutter/material.dart';
import 'package:res_task/features/home/presentation/widgets/product_details/product_details_body.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../data/models/home_model/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.pColor),
        centerTitle: true,
        title: Text(
          product.name,
          style: Styles.textStyle18bold.copyWith(color: AppColors.pColor),
        ),
      ),
      body:ProductDetailsBody(product: product)
    );
  }
}


