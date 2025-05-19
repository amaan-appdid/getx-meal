import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        final cart = controller.cartItems;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text("Cart Products"),
          ),
          body: cart.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return Card();
                  },
                ),
        );
      },
    );
  }
}
