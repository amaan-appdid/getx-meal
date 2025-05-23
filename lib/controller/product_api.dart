import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_meal/Api/appconstants.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductApiController extends GetxController implements GetxService {
  bool isLoading = false;
  String error = "";
  List<ProductModel> productList = [];

  Future<void> getProducts({required String title}) async {
    isLoading = true;
    update();

    try {
      final response = await http.get(Uri.parse("${Appconstants().productApi}$title"));
      log(response.body.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["meals"];
        productList = jsonData.map((e) => ProductModel.fromJson(e)).toList();

        log("${productList}");
        error = "";
      } else {
        error = "Failed to load data";
      }
    } catch (e) {
      error = "An error occurred: $e";
    }
    isLoading = false;
    update();
  }

  void toggleLike(String id) {
    final index = productList.indexWhere((p) => p.idMeal == id);
    if (index != -1) {
      productList[index].isLiked = !productList[index].isLiked;
      update();
    }
  }

  // List<ProductModel> cartItems = [];

  // void addToCart(product) {
  //   if (!cartItems.contains(product)) {
  //     cartItems.add(product);
  //     update(); // Notify UI
  //   }
  // }

  void like(String id) {
    final index = productList.indexWhere((p) => p.idMeal == id);
    if (index != -1) {
      productList[index].isLiked = !productList[index].isLiked;
      update();
    }
  }

  List<ProductModel> get likedProducts => productList.where((p) => p.isLiked).toList();

  void cart(String id) {
    final index = productList.indexWhere((p) => p.idMeal == id);
    if (index != -1) {
      productList[index].isLiked = !productList[index].isLiked;
      update();
    }
  }

  List<ProductModel> get cartProducts => productList.where((p) => p.isLiked).toList();
}
