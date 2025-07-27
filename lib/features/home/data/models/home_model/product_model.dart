class ProductModel {
  final String id;
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final String deliveryTime;
  final List<String> ingredients;
  final String description;

  ProductModel( {
    required this.id,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.deliveryTime,
    required this.ingredients,
    required this.description,
  });
}
