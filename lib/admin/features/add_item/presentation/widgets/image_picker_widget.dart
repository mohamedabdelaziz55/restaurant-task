import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/app_colors.dart';
import '../riverpod/add_item_river_pod.dart';

class ImagePickerWidget extends ConsumerWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(addItemProvider).image;

    return GestureDetector(
      onTap: () => ref.read(addItemProvider.notifier).pickImage(),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(image, fit: BoxFit.cover),
        )
            : const Center(child: Icon(Icons.camera_alt, size: 40, color: AppColors.grey)),
      ),
    );
  }
}
