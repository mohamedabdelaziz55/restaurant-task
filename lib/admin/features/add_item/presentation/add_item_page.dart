import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:res_task/admin/features/add_item/presentation/riverpod/add_item_river_pod.dart';
import 'package:res_task/admin/features/add_item/presentation/widgets/image_picker_widget.dart';
import 'package:res_task/admin/features/add_item/presentation/widgets/item_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class AddItemPage extends ConsumerWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addItemProvider);

    final provider = ref.read(addItemProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Item",
          style: TextStyle(color: AppColors.pColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        titleTextStyle: Styles.textStyle20bold.copyWith(color: AppColors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload the Item Picture",
              style: Styles.textStyle16bold.copyWith(color: AppColors.pColor),
            ),
            const SizedBox(height: 10),
            const ImagePickerWidget(),
            const SizedBox(height: 20),
            ItemTextField(
              label: "Item Name",
              controller: provider.nameController,
              hint: "Enter Item Name",
            ),
            const SizedBox(height: 16),
            ItemTextField(
              label: "Item Price",
              controller: provider.priceController,
              hint: "Enter Item Price",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ItemTextField(
              label: "Item Detail",
              controller: provider.detailController,
              hint: "Enter Item Detail",
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: state.selectedCategory,
              items: const [
                DropdownMenuItem(value: "Ice-cream", child: Text("Ice-cream")),
                DropdownMenuItem(value: "Burger", child: Text("Burger")),
                DropdownMenuItem(value: "Salad", child: Text("Salad")),
                DropdownMenuItem(value: "Pizza", child: Text("Pizza")),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(addItemProvider.notifier).changeCategory(value);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Is there an offer on the product?",
                  style: Styles.textStyle16bold.copyWith(color: AppColors.pColor),
                ),
                Switch(
                  value: state.hasOffer,
                  onChanged: (value) {
                    ref.read(addItemProvider.notifier).toggleHasOffer(value);
                  },
                  activeColor: AppColors.pColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pColor,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () =>
                  ref.read(addItemProvider.notifier).submitItem(context),
              child: Text(
                "Add Item",
                style: Styles.textStyle18.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
