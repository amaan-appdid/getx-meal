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

  /// Set of favorite meal IDs
  final Set<String> _favoriteMealIds = {};

  /// Public getter for favorite status
  bool isFavorite(String mealId) => _favoriteMealIds.contains(mealId);

  /// Toggle favorite status
  void toggleFavorite(String mealId) {
    if (_favoriteMealIds.contains(mealId)) {
      _favoriteMealIds.remove(mealId);
      log(" Removed from favorites: $mealId");
    } else {
      _favoriteMealIds.add(mealId);
      log(" Added to favorites: $mealId");
    }
    update(); // Notify listeners
  }

  Future<void> getSearch(String query) async {
    log(" Fetching data for query: $query");
    isLoading = true;
    update();

    try {
      final response = await http.get(Uri.parse("${Appconstants().serchApi}$query"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        log(" Status Code: ${response.statusCode}");

        if (jsonData["meals"] != null) {
          searchList = (jsonData["meals"] as List).map((e) => SearchModel.fromJson(e)).toList();
          error = "";
          log(" Found ${searchList.length} meals");
        } else {
          searchList.clear();
          error = " No meals found for \"$query\".";
          log(" No meals found");
        }
      } else {
        error = "Failed to load data (Status code: ${response.statusCode})";
        log(error);
      }
    } catch (e) {
      error = "❗ An error occurred: $e";
      log(error);
    } finally {
      isLoading = false;
      update();
    }
  }

  void clearResults() {
    searchList.clear();
    error = '';
    update();
    log("🧹 Cleared search results");
  }
}
