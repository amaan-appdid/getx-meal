import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/product_api.dart';
import 'package:get_meal/views/cart_screen.dart';
import 'package:get_meal/views/detail_page.dart';
import 'package:get_meal/views/search_screen.dart';

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
              ? const Center(child: CircularProgressIndicator())
              : controller.error.isNotEmpty
                  ? Center(child: Text(controller.error))
                  : ListView.builder(
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
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
                              trailing: IconButton(
                                icon: Icon(
                                  product.isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: product.isLiked ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  controller.toggleLike(product.idMeal);
                                },
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
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.shopping_cart),
          ),
        );
      },
    );
  }
}
