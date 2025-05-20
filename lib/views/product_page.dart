import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/cart_controller.dart';
import 'package:get_meal/controller/product_api.dart';
import 'package:get_meal/views/cart_screen.dart';

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
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => likeScreens(),
                ),
              );
            },
            icon: Icon(Icons.favorite),
          )
        ],
      ),
      body: GetBuilder<ProductApiController>(builder: (controller) {
        return GetBuilder<CartController>(builder: (cartCtrl) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.productList.isEmpty) {
            return Center(child: Text('No Data Found'));
          }
          return ListView.builder(
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
                        cartCtrl.cartItems.firstWhereOrNull(
                                  (item) => item.idMeal == product.idMeal,
                                ) ==
                                null
                            ? TextButton(
                                onPressed: () {
                                  cartCtrl.addItem(product);
                                  // log("Added");
                                  // .(product);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            : Container(
                                child: Text(
                                  "Added To Cart",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(),
            ),
          );
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.shopping_cart,
        ),
      ),
    );
  }
}
