import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/product_api.dart';
import 'package:get_meal/views/detail_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductApiController>(
      builder: (controller) {
        final likedItems = controller.likedProducts;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Liked Products"),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: likedItems.isEmpty
              ? const Center(child: Text("No liked products yet."))
              : ListView.builder(
                  itemCount: likedItems.length,
                  itemBuilder: (context, index) {
                    final product = likedItems[index];
                    return Card(
                      child: ListTile(
                        title: Text(product.strMeal),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(product.strMealThumb),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.toggleLike(product.idMeal);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(
                                id: product.idMeal,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
