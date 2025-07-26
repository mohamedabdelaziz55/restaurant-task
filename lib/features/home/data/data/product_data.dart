import '../../../../core/utils/assets.dart';
import '../models/home_model/product_model.dart';

final List<ProductModel> products = [
  ProductModel(
    imagePath: AssetsData.pizza,
    title: 'Pizza',
    subtitle: 'Fresh and Healthy',
    price: '45',
  ),
  ProductModel(
    imagePath: AssetsData.burger,
    title: 'Burger',
    subtitle: 'Juicy and Spicy',
    price: '60',
  ),
  ProductModel(
    imagePath: AssetsData.salad,
    title: 'Salad',
    subtitle: 'Light and Fresh',
    price: '30',
  ),
  ProductModel(
    imagePath: AssetsData.iceCream,
    title: 'Ice Cream',
    subtitle: 'Cold and Sweet',
    price: '20',
  ),
];