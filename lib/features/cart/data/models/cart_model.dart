import '../../../home/data/models/home_model/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product': {
        'id': product.id,
        'image': product.image,
        'name': product.name,
        'detail': product.detail,
        'price': product.price,
        'category': product.category,
        'isOffer': product.isOffer,
      },
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    final productMap = map['product'];
    return CartItemModel(
      product: ProductModel(
        id: productMap['id'],
        image: productMap['image'],
        name: productMap['name'],
        detail: productMap['detail'],
        price: (productMap['price'] as num).toDouble(),
        category: productMap['category'],
        isOffer: productMap['isOffer'],
      ),
      quantity: map['quantity'],
    );
  }
}