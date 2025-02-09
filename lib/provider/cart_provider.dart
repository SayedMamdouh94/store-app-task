import 'package:flutter/material.dart';
import 'package:store_api/model/cart_model.dart';
import 'package:store_api/model/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItemData> _cartItems = {};
  bool _isLoading = false;
  Map<String, CartItemData> get cartItems => Map.unmodifiable(_cartItems);

  bool get isLoading => _isLoading;

  Future<void> addItemToCart(Product product) async {
    if (_cartItems.containsKey(product.id.toString())) {
      _cartItems[product.id.toString()]!.quantity += 1;
    } else {
      _cartItems[product.id.toString()] =
          CartItemData(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void increaseQuantity(String id) {
    if (_cartItems.containsKey(id)) {
      _cartItems[id]!.quantity += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    if (_cartItems.containsKey(id)) {
      if (_cartItems[id]!.quantity > 1) {
        _cartItems[id]!.quantity -= 1;
      }
    } else {
      removeFromCart(id);
    }
    notifyListeners();
  }

  Future<void> removeAllFromCart() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    _cartItems.clear();
    _isLoading = false;
    notifyListeners();
  }
}
