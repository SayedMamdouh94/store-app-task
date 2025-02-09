import 'dart:convert';
import 'package:store_api/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String productApi = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(productApi));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Product> products = [];
      for (var item in data) {
        products.add(Product.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
