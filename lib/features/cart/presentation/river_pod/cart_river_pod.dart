
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home/data/models/home_model/product_model.dart';
import '../../data/models/cart_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemModel>>(
      (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]) {
    loadCartFromPrefs();
  }

  void addToCart(ProductModel product, int quantity) async {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      state[index] = CartItemModel(
        product: product,
        quantity: state[index].quantity + quantity,
      );
    } else {
      state = [...state, CartItemModel(product: product, quantity: quantity)];
    }

    await saveCartToPrefs();
  }

  void clearCart() async {
    state = [];
    await saveCartToPrefs();
  }

  double get total => state.fold(0, (sum, item) => sum + item.totalPrice);

  Future<void> saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartList = state.map((item) => item.toMap()).toList();
    prefs.setString('user_cart', jsonEncode(cartList));
  }

  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('user_cart');
    if (cartString != null) {
      final List<dynamic> decoded = jsonDecode(cartString);
      state = decoded
          .map((item) => CartItemModel.fromMap(item as Map<String, dynamic>))
          .toList();
    }
  }
}
