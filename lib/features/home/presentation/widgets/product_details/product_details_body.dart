import 'package:flutter/material.dart';
import 'package:res_task/features/home/data/models/home_model/product_model.dart';
import 'package:res_task/features/home/presentation/widgets/product_details/product_info.dart';
import 'package:res_task/features/home/presentation/widgets/product_details/total_price.dart';
import 'custom_product_image.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key, required this.product});
final ProductModel product;
  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Column(
      children: [
        ProductImageWidget(imagePath: widget.product.imagePath),
        SizedBox(height: width * 0.04),
        Expanded(
          child: ProductInfo(
            product: widget.product,
            quantity: quantity,
            onIncrement: () {
              setState(() => quantity++);
            },
            onDecrement: () {
              if (quantity > 1) setState(() => quantity--);
            },
          ),
        ),
        TotalPrice(

          price: widget.product.price,
          quantity: quantity,
        ),
      ],
    );
  }
}
