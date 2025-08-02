import 'dart:io';

class AddItemState {
  final File? image;
  final String selectedCategory;
  final bool hasOffer;
  final bool isLoading;

  AddItemState({
    this.image,
    this.selectedCategory = "Pizza",
    this.hasOffer = false,
    this.isLoading = false,
  });

  AddItemState copyWith({
    File? image,
    String? selectedCategory,
    bool? hasOffer,
    bool? isLoading,
  }) {
    return AddItemState(
      image: image ?? this.image,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      hasOffer: hasOffer ?? this.hasOffer,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
