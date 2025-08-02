import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../river_pod/products_river_pod.dart';
import 'product_card.dart';

class CustomListViewVertical extends ConsumerWidget {
  const CustomListViewVertical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final asyncProducts = ref.watch(productsProvider(selectedCategory));

    return asyncProducts.when(
      data: (products) {
        return Column(
          children: products
              .map((product) => ProductCard2(product: product))
              .toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading products: $e')),
    );
  }
}