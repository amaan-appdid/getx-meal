class ProductModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  bool isLiked;

  ProductModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.isLiked = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}
