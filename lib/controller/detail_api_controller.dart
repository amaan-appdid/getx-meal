import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_meal/Api/appconstants.dart';
import 'package:http/http.dart' as http;

import '../models/detail_model.dart';

class DetailApiController extends GetxController implements GetxService {
  bool isLoading = false;
  String error = "";

  List<DetailModel> detailList = [];

  Future<void> getDetails({required String id}) async {
    log("Fetching Data From Api...");
    isLoading = true;
    update();

    try {
      final response = await http.get(Uri.parse("${Appconstants().descriptionApi}$id"));
      log("Response Recieved: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)["meals"];
        detailList = jsonData.map((e) => DetailModel.fromJson(e)).toList();
        error = "";
      } else {
        error = "Failed to Load data";
      }
    } catch (e) {
      error = "An Error Occured: $e";
    } finally {
      isLoading = false;
      update();
    }
  }
}
