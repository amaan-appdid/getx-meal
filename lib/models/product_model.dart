class ProductModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  bool isLiked;
  int quantity;

  ProductModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.isLiked = false,
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}
