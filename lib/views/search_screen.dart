import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/search_api_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController search = TextEditingController();
  // ignore: unused_element
  void _search() {
    final query = search.text.trim();
    if (query.isNotEmpty) {}
  }

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<SearchApiController>().getSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search Meals"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Enter Meal name ",
              suffixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
          GetBuilder<SearchApiController>(
            builder: (controller) {
              if (controller.isLoading)
                Expanded(child: Center(child: CircularProgressIndicator()));
              else if (controller.searchList.isEmpty) Text("No Meals Found");
              return ListView.builder(
                itemCount: controller.searchList.length,
                itemBuilder: (context, index) {
                  final meal = controller.searchList[index];
                  return ListTile(
                    title: Text(meal.strInstructions),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        meal.strMealThumb,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
