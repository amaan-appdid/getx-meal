import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Cart Products"),
      ),
      body: GetBuilder<CartController>(builder: (cartCtrl) {
        if (cartCtrl.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cartCtrl.cartItems.isEmpty) {
          return const Center(child: Text("No Items in Cart"));
        }

        return ListView.builder(
          itemCount: cartCtrl.cartItems.length,
          itemBuilder: (context, index) {
            final product = cartCtrl.cartItems[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.strMealThumb),
                  ),
                  title: Text(product.strMeal),
                  subtitle: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartCtrl.decrementQuantity(product);
                        },
                      ),
                      Text('Qty: ${product.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartCtrl.incrementQuantity(product);
                        },
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartCtrl.removeItem(product);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
