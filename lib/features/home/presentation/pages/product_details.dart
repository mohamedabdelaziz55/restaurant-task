import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../data/models/home_model/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.black),
        centerTitle: true,
        title: Text(
          widget.product.title,
          style: Styles.textStyle18bold,
        ),
      ),
      body: Column(
        children: [
          ProductImageWidget(imagePath: widget.product.imagePath),
          SizedBox(height: width * 0.04),
          Expanded(
            child: ProductInfoSection(
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
          TotalPriceSection(
            price: widget.product.price,
            quantity: quantity,
          ),
        ],
      ),
    );
  }
}

//***********************************************
// Image Widget
class ProductImageWidget extends StatelessWidget {
  final String imagePath;

  const ProductImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Image.asset(
        imagePath,
        height: height * 0.25,
        fit: BoxFit.contain,
      ),
    );
  }
}

//***********************************************
// Info Section
class ProductInfoSection extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductInfoSection({
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
          Text(product.title, style: Styles.textStyle24bold),
          SizedBox(height: width * 0.02),
          Text(
            product.subtitle,
            style: Styles.textStyle14.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: width * 0.04),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 20),
              const SizedBox(width: 8),
              Text('Delivery Time: 30 min', style: Styles.textStyle14),
            ],
          ),
          SizedBox(height: width * 0.05),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$quantity', style: Styles.textStyle16bold),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//***********************************************
// Total Price + Button Section
class TotalPriceSection extends StatelessWidget {
  final String price;
  final int quantity;

  const TotalPriceSection({
    super.key,
    required this.price,
    required this.quantity,
  });

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
          )
        ],
      ),
      child: Row(
        children: [
          Text('Total Price', style: Styles.textStyle16),
          const Spacer(),
          Text('\$${total.toStringAsFixed(2)}', style: Styles.textStyle18bold),
          SizedBox(width: width * 0.04),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Add to cart'),
          ),
        ],
      ),
    );
  }
}
