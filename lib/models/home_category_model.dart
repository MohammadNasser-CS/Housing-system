class HomeCategoryModel {
  final String category;
  final String imgUrl;
  final int productsNumber;

  HomeCategoryModel({
    required this.category,
    required this.imgUrl,
    required this.productsNumber,
  });
}

List<HomeCategoryModel> dummyCategories = [
  HomeCategoryModel(
    category: 'أستوديو',
    imgUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/174877128.jpg?k=3a3c68049361dc14ffe0ae899188919753ed93785369d78c5eb4ada19c0ac50d&o=&hp=1',
    productsNumber: 6,
  ),
  HomeCategoryModel(
      category: 'شقة',
      imgUrl:
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/526430748.jpg?k=8b5081f7aa328ed80ece747f8ab676b9cd273c2fbf9e97d04fb1b1bce725b70b&o=&hp=1',
      productsNumber: 12),
];

// List<HomeCategoryModel> dunnyOwnerHomeCategories = [
//   HomeCategoryModel(category: 'المتاحة', imgUrl: 'imgUrl', productsNumber: 1),
//   HomeCategoryModel(category: 'المحجوزة', imgUrl: 'imgUrl', productsNumber: 1),
// ];
