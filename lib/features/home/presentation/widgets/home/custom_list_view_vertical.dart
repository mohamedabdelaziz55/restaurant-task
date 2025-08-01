import 'package:flutter/material.dart';
import 'package:res_task/features/home/presentation/widgets/home/product_card.dart';

import '../../../data/data/product_data.dart';



class CustomListViewVertical extends StatelessWidget {
  const CustomListViewVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        products.length,
            (index) => ProductCard2(product: products[index]),
      ),
    );
  }
}