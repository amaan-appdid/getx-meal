import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/product_api.dart';
import 'package:get_meal/views/detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      await Get.find<ProductApiController>().getProducts(
        title: widget.title,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductApiController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [],
            title: Text(widget.title),
            // leading: CircleAvatar(
            //     backgroundColor: Colors.transparent,
            //     child: Image.network(
            //       widget.imageUrl,
            //       fit: BoxFit.cover,
            //     )),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.error.isNotEmpty
                  ? Center(
                      child: Text(controller.error),
                    )
                  : ListView.builder(
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.12),
                                )
                              ],
                            ),
                            child: Card(
                              color: Colors.white,
                              elevation: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        id: product.idMeal,
                                        title: product.strMeal,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(product.strMeal),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    product.strMealThumb,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
