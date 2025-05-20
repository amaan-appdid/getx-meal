import 'package:get/get.dart';
import 'package:get_meal/models/product_model.dart';

class CartController extends GetxController {
  List<ProductModel> cartItems = [];
  bool isLoading = false;

  void addItem(ProductModel product) {
    isLoading = true;
    final existingProduct = cartItems.firstWhereOrNull((item) => item.idMeal == product.idMeal);

    if (existingProduct == null) {
      product.quantity = 1;
      cartItems.add(product);
    } else {
      existingProduct.quantity++;
    }

    isLoading = false;
    update();
  }

  void removeItem(ProductModel product) {
    isLoading = true;
    cartItems.removeWhere((item) => item.idMeal == product.idMeal);
    isLoading = false;
    update();
  }

  void incrementQuantity(ProductModel product) {
    final existingProduct = cartItems.firstWhereOrNull((item) => item.idMeal == product.idMeal);
    if (existingProduct != null) {
      existingProduct.quantity++;
      update();
    }
  }

  void increment(ProductModel product) {
    final existingProduct = cartItems.firstWhereOrNull(
      (element) => element.idMeal == product.idMeal,
    );
    if (existingProduct == null) {
      product.quantity = 1;
      cartItems.add(product);
    } else {
      existingProduct.quantity++;
    }
  }

  void decrementQuantity(ProductModel product) {
    final existingProduct = cartItems.firstWhereOrNull((item) => item.idMeal == product.idMeal);
    if (existingProduct != null) {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
      } else {
        cartItems.remove(existingProduct);
      }
      update();
    }
  }

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
}
