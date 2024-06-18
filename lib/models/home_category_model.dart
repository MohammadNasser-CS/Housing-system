class HomeCategoryModel {
  final String categoryId;
  final String category;
  final bool isSelected;
  HomeCategoryModel({
    required this.categoryId,
    required this.category,
     this.isSelected=false,
  });
}

List<HomeCategoryModel> categories = [
  HomeCategoryModel(
    categoryId: '1',
    category: 'أستوديو',
  ),
  HomeCategoryModel(
    categoryId: '2',
    category: 'شقة',
  ),
];
