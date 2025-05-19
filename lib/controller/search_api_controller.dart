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

  Future<void> getSearch(String query) async {
    log("🔍 Fetching data for query: $query");
    isLoading = true;
    update();

    try {
      final response = await http.get(Uri.parse("${Appconstants().serchApi}$query"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["meals"] != null) {
          searchList = (jsonData["meals"] as List).map((e) => SearchModel.fromJson(e)).toList();
          error = "";
          log(" Found ${searchList.length} meals");
        } else {
          searchList.clear();
          error = "No meals found for \"$query\".";
          log(" No meals found");
        }
      } else {
        error = " Failed to load data (Status code: ${response.statusCode})";
        log(error);
      }
    } catch (e) {
      error = " An error occurred: $e";
      log(error);
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Clears search results and errors
  void clearResults() {
    searchList.clear();
    error = '';
    update();
    log("🧹 Cleared search results");
  }
}
