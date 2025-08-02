class ProductModel {
  final String id;
  final String image;
  final String name;
  final String detail;
  final double price;
  final String category;
  final bool isOffer;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.category,
    required this.isOffer,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      detail: data['detail'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      isOffer: data['isOffer'] ?? false,
    );
  }
}
