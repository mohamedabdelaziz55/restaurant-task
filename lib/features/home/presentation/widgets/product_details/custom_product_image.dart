import 'package:flutter/material.dart';

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