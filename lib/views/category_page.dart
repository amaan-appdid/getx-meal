import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/views/product_page.dart';
import '../controller/categories_api.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    Timer.run(() async {
      await Get.find<CategoriesApiController>().getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesApiController>(
      builder: (Controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Categories'),
          ),
          body: Controller.isLoding
              ? const Center(child: CircularProgressIndicator())
              : Controller.error.isNotEmpty
                  ? Center(child: Text(Controller.error))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: Controller.categoryList.length,
                      itemBuilder: (context, index) {
                        final category = Controller.categoryList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  title: category.strCategory,
                                  imageUrl: category.strCategoryThumb,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                  color: Colors.black.withOpacity(0.12),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  category.strCategoryThumb,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    category.strCategory,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Text(
                                  category.strCategoryDescription,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ).paddingOnly(left: 8)
                              ],
                            ),
                          ).marginAll(10),
                        );
                      },
                    ),
        );
      },
    );
  }
}
