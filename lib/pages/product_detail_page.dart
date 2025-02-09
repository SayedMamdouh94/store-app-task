import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/model/product_model.dart';
import 'package:store_api/provider/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Detail"),
        actions: [
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return IconButton(
              onPressed: () {
                cartProvider.addItemToCart(widget.product);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Item added to cart!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
            );
          }),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 800;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: isLargeScreen ? 500 : 350, // Adjusting image size
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.product.image,
                        filterQuality: FilterQuality.high,
                        width: double.infinity,
                        height: isLargeScreen ? 450 : 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.product.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: isLargeScreen ? 28 : 24, // Adjusting font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          widget.product.rating.rate.toString(),
                          style: TextStyle(
                            fontSize: isLargeScreen ? 20 : 18,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        Text(
                          ' (${widget.product.rating.count} reviews)',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 16 : 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.product.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Divider(
                  height: 32,
                  thickness: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18 : 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    height: 1.5,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
