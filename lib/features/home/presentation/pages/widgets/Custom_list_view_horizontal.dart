import 'package:flutter/material.dart';
import 'package:res_task/features/home/presentation/pages/widgets/product_card.dart';

import '../../../data/data/product_data.dart';

class CustomListViewHorizontal extends StatelessWidget {
  const CustomListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:  MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}