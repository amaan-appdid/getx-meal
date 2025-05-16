import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_meal/Api/appconstants.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as htttp;

class ProductApiController extends GetxController implements GetxService {
  bool isLoading = false;
  String error = "";

  List<ProductModel> productList = [];

  Future<void> getProducts({required String title}) async {
    log("Fetching Data From Api");
    isLoading = true;
    update();

    try {
      final response = await htttp.get(Uri.parse("${Appconstants().productApi}$title"));
      log("Response Recieved ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["meals"];
        productList = jsonData.map((e) => ProductModel.fromJson(e)).toList();
        error = "";
      } else {
        error = "Failde To Load Data";
      }
    } catch (e) {
      error = " An Error Occured ${e}";
    } finally {
      isLoading = false;
      update();
    }
  }
}
