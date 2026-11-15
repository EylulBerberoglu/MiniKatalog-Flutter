
import 'package:flutter/foundation.dart';
import 'models/product.dart';

class Cart {
  static final ValueNotifier<List<Product>> items =
      ValueNotifier<List<Product>>([]);

  static void addProduct(Product product) {
    items.value = [...items.value, product];
  }

  static void removeProduct(Product product) {
    final updatedItems = List<Product>.from(items.value);
    updatedItems.remove(product);
    items.value = updatedItems;
  }

  static void clearCart() {
    items.value = [];
  }

  static double get totalPrice {
    return items.value.fold(
      0,
      (total, product) => total + product.price,
    );
  }
}
