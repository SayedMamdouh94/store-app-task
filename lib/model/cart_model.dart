import 'package:store_api/model/product_model.dart';

class CartItemData {
  final Product product;
  int quantity;

  CartItemData({
    required this.product,
    this.quantity = 1,
  });
}
