import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:res_task/features/home/presentation/widgets/home/product_card.dart';

import '../../../../../admin/features/add_item/presentation/riverpod/add_item_river_pod.dart';
import '../../river_pod/products_river_pod.dart';


class CustomListViewHorizontal extends ConsumerWidget {
  const CustomListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final offersAsync = ref.watch(offerProductsProvider);

    return offersAsync.when(
      data: (products) {
        final filteredProducts = selectedCategory == null
            ? products
            : products.where((product) => product.category == selectedCategory).toList();

        if (filteredProducts.isEmpty) {
          return const Center(child: Text("No offers in this category."));
        }

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            itemCount: filteredProducts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCard(product: filteredProducts[index]);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }
}
