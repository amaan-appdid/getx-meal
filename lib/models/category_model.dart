// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    String idCategory;
    String strCategory;
    String strCategoryThumb;
    String strCategoryDescription;

    CategoryModel({
        required this.idCategory,
        required this.strCategory,
        required this.strCategoryThumb,
        required this.strCategoryDescription,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
    );

    Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
    };
}
