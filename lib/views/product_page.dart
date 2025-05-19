import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/product_api.dart';

import 'package:get_meal/views/detail_page.dart';
import 'package:get_meal/views/like_screen.dart';
import 'package:get_meal/views/search_screen.dart'; // Import the cart screen

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
      await Get.find<ProductApiController>().getProducts(title: widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductApiController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: controller.isLoading
              ? ListView.builder(
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircularProgressIndicator(),
                        title: Text("Loading..."),
                      ),
                    );
                  },
                )
              : controller.error.isNotEmpty
                  ? Center(child: Text(controller.error))
                  : ListView.builder(
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      id: product.idMeal,
                                    ),
                                  ),
                                );
                              },
                              title: Text(product.strMeal),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(product.strMealThumb),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      product.isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: product.isLiked ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      controller.toggleLike(product.idMeal);
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.addToCart(product);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      'Add to Cart',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => likeScreens(),
                ),
              );
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(
              Icons.shopping_cart,
            ),
          ),
        );
      },
    );
  }
}
