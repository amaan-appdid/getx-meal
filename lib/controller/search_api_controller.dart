import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_meal/Api/appconstants.dart';

import '../models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchApiController extends GetxController implements GetxService {
  bool isLoading = false;
  String error = "";

  List<SearchModel> searchList = [];

  Future<void> getSearch() async {
    log("Fetching data From Api...");
    isLoading = true;
    update();

    try {
      final response = await http.get(Uri.parse("${Appconstants().serchApi}"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["meals"];

        searchList = jsonData.map((e) => SearchModel.fromJson(e)).toList();
        error = "";
      } else {
        error = "Failed To load Data";
      }
    } catch (e) {
      error = "An Error Occured$e";
    } finally {
      isLoading = false;
      update();
    }
  }
}
