import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String imagePath;

  const ProductImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return CachedNetworkImage(
      imageUrl: imagePath,
      height: height * 0.25,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
