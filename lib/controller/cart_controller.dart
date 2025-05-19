import 'package:get/get.dart';

class CartController extends GetxController implements GetxService {
  Map<String, int> cartItems = {};

  void addItem(String productId) {
    if (cartItems.containsKey(productId)) {
      cartItems[productId] = cartItems[productId]! + 1;
    } else {
      cartItems[productId] = 1;
    }
    update();
  }

  void removeItem(String productId) {
    if (cartItems.containsKey(productId)) {
      if (cartItems[productId]! > 1) {
        cartItems[productId] = cartItems[productId]! - 1;
      } else {
        cartItems.remove(productId);
      }
    }
    update();
  }

  int get totalItems => cartItems.values.fold(0, (sum, qty) => sum + qty);
}