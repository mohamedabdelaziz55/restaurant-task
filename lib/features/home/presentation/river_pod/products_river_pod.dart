import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ data/service/database_dart.dart';
import '../../data/models/home_model/product_model.dart';

final productServiceProvider = Provider<ProductService>((ref) => ProductService());

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final productsProvider = FutureProvider.family<List<ProductModel>, String?>((ref, category) async {
  final service = ref.watch(productServiceProvider);
  final allProducts = await service.getAllProducts();

  if (category == null) return allProducts;

  return allProducts
      .where((product) => product.category.toLowerCase() == category.toLowerCase())
      .toList();
});
