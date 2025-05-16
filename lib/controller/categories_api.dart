import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_meal/Api/appconstants.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

class CategoriesApiController extends GetxController implements GetxService {
  bool isLoding = false;
  String error = "";

  List<CategoryModel> categoryList = [];

  Future<void> getCategories() async {
    log("Fetching Data From Api");

    isLoding = true;
    update();

    try {
      final response = await http.get(Uri.parse(Appconstants().categoriesApi));
      log("Response Recieved:${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["categories"];

        categoryList = jsonData.map((e) => CategoryModel.fromJson(e)).toList();
        error = "";
      } else {
        error = "Failed to Load Data: ${response.statusCode}";
      }
    } catch (e) {
      error = "An error occurred: $e";
    } finally {
      isLoding = false;
      update();
    }
  }
}
