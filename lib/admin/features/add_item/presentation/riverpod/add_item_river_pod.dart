import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:res_task/core/routes/app_route.dart';
import 'package:res_task/core/utils/app_colors.dart';
import 'package:res_task/core/utils/custom_snack_bar.dart';

import '../../../../../core/ data/service/database_dart.dart';
import '../../../../../features/home/data/models/home_model/product_model.dart';
import '../../../../../features/home/presentation/river_pod/products_river_pod.dart';
import 'add_product_state.dart';



final offerProductsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final service = ref.watch(productServiceProvider);
  final allProducts = await service.getAllProducts();

  return allProducts.where((product) => product.isOffer == true).toList();
});

final addItemProvider = StateNotifierProvider<AddItemNotifier, AddItemState>(
      (ref) => AddItemNotifier(),
);

class AddItemNotifier extends StateNotifier<AddItemState> {
  AddItemNotifier() : super(AddItemState());
  void toggleHasOffer(bool value) {
    state = state.copyWith(hasOffer: value);
  }
  final _dbService = ItemDatabaseService();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final detailController = TextEditingController();

  void changeCategory(String newCategory) {
    state = state.copyWith(selectedCategory: newCategory);
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file != null) {
      state = state.copyWith(image: File(file.path));
    }
  }

  Future<String?> uploadImageToImgbb(File imageFile) async {
    const apiKey = '2e5da8ff7d6a0ea3fe8228bc27ffb0fb';
    final uri = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");
    final base64Image = base64Encode(imageFile.readAsBytesSync());

    final response = await http.post(
      uri,
      body: {
        "image": base64Image,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['url'];
    } else {
      debugPrint('Image upload failed: ${response.body}');
      return null;
    }
  }
  Future<void> submitItem(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);

      if (state.image == null ||
          nameController.text.isEmpty ||
          priceController.text.isEmpty ||
          detailController.text.isEmpty) {
        CustomSnackBar.show(
          context,
          colorText: AppColors.white,
          message: 'All fields are required!',
          backgroundColor: AppColors.errorRed,
          icon: Icons.warning,
        );
        state = state.copyWith(isLoading: false);
        return;
      }

      final imageUrl = await uploadImageToImgbb(state.image!);
      if (imageUrl == null) throw Exception("Image upload failed");

      final itemData = {
        'name': nameController.text,
        'price': double.parse(priceController.text),
        'detail': detailController.text,
        'image': imageUrl,
        'category': state.selectedCategory,
        'createdAt': FieldValue.serverTimestamp(),
        'isOffer': state.hasOffer,
      };

      await _dbService.addItem(itemData);

      CustomSnackBar.show(
        context,
        colorText: AppColors.white,
        message: 'Item added successfully!',
        backgroundColor: AppColors.green,
        icon: Icons.check_circle,
      );

      nameController.clear();
      priceController.clear();
      detailController.clear();
      state = AddItemState();

      GoRouter.of(context).pushReplacement(AppRouter.kHomeAdminPage);

    } catch (e) {
      CustomSnackBar.show(
        context,
        colorText: AppColors.white,
        message: 'Failed to add item: $e',
        backgroundColor: AppColors.errorRed,
        icon: Icons.error,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

}
