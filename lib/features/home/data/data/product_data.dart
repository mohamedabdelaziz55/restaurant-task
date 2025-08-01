import '../../../../core/utils/assets.dart';
import '../models/home_model/product_model.dart';

final List<ProductModel> products = [
  ProductModel(
    id: '1',
    imagePath: AssetsData.pizza,
    title: 'Pizza',
    subtitle: 'Fresh and Healthy',
    price: '45',
    deliveryTime: '25 - 30 min',
    ingredients: ['Tomato Sauce', 'Mozzarella', 'Basil', 'Olives', 'Pepperoni'],
    description:
    'Our freshly baked pizza is made with hand-tossed dough, topped with a rich tomato sauce, premium mozzarella cheese, and your favorite toppings. A classic Italian taste.',
  ),
  ProductModel(
    id: '2',
    imagePath: AssetsData.burger,
    title: 'Burger',
    subtitle: 'Juicy and Spicy',
    price: '60',
    deliveryTime: '20 - 25 min',
    ingredients: ['Beef Patty', 'Lettuce', 'Tomato', 'Cheddar Cheese', 'Spicy Sauce'],
    description:
    'This burger features a juicy grilled beef patty layered with fresh lettuce, tomatoes, cheddar cheese, and our signature spicy sauce, all inside a toasted bun.',
  ),
  ProductModel(
    id: '3',
    imagePath: AssetsData.salad,
    title: 'Salad',
    subtitle: 'Light and Fresh',
    price: '30',
    deliveryTime: '15 - 20 min',
    ingredients: ['Lettuce', 'Cucumber', 'Cherry Tomatoes', 'Feta Cheese', 'Olive Oil'],
    description:
    'A refreshing salad made with crisp lettuce, juicy cherry tomatoes, cool cucumbers, feta cheese, and a drizzle of extra virgin olive oil. Perfect for a light meal.',
  ),
  ProductModel(
    id: '4',
    imagePath: AssetsData.iceCream,
    title: 'Ice Cream',
    subtitle: 'Cold and Sweet',
    price: '20',
    deliveryTime: '10 - 15 min',
    ingredients: ['Milk', 'Sugar', 'Vanilla', 'Strawberries', 'Chocolate Chips'],
    description:
    'Deliciously cold and creamy, our ice cream is made with real milk and natural ingredients. Choose from a variety of flavors topped with strawberries or chocolate chips.',
  ),
];
