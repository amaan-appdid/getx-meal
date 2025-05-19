import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/search_api_controller.dart';
import 'package:get_meal/views/detail_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  void _search() {
    final query = searchController.text.trim();
    if (query.isNotEmpty) {
      Get.find<SearchApiController>().getSearch(query);
    }
  }

  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        focusNode.requestFocus();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchControllerInstance = Get.find<SearchApiController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Search Meals"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  _search();
                });
              },
              onSubmitted: (_) => _search(),
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: "Enter meal name",
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          FocusScope.of(context).unfocus();
                          setState(() {}); // Refresh UI
                          searchControllerInstance.clearResults();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _search,
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GetBuilder<SearchApiController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.error.isNotEmpty) {
                    log(controller.error);
                    return Center(child: Text(controller.error));
                  }

                  if (controller.searchList.isEmpty) {
                    return const Center(child: Text("No meals to display."));
                  }

                  return ListView.builder(
                    itemCount: controller.searchList.length,
                    itemBuilder: (context, index) {
                      final meal = controller.searchList[index];
                      return Card(
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.10),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(id: meal.idMeal),
                                ),
                              );
                            },
                            title: Text(meal.strMeal),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(meal.strMealThumb),
                            ),
                            subtitle: Text(
                              meal.strInstructions,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                controller.isFavorite(meal.idMeal) ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.toggleFavorite(meal.idMeal);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
