import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/provider/cart_provider.dart';
import 'package:store_api/utils/dialogbox.dart';
import 'package:store_api/widgets/cart_list_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          IconButton(
            onPressed: () async {
              final cartProvider =
                  Provider.of<CartProvider>(context, listen: false);
              if (!cartProvider.isLoading) {
                bool? result = await showDialogBox(
                  context,
                  "Remove From Cart",
                  "Are you sure you want to remove all items from the cart?",
                );
                if (result == true) {
                  cartProvider.removeAllFromCart();
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        if (cartProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final cartItems = cartProvider.cartItems;
        double totalPrice = cartItems.values.fold(
          0.0,
          (sum, item) => sum + (item.product.price * item.quantity),
        );
        int totalItem = cartProvider.cartItems.values
            .fold(0, (sum, item) => sum + (item.quantity));

        if (cartItems.isEmpty) {
          return const Center(
            child: Text("Your cart is empty.", style: TextStyle(fontSize: 18)),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 800;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems.values.elementAt(index);
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 32 : 16,
                          vertical: 8,
                        ),
                        child: CartListTile(
                          item: item,
                          cartProvider: cartProvider,
                        ),
                      );
                    },
                  ),
                ),

                //bottomContainer
                Container(
                  padding: EdgeInsets.all(isLargeScreen ? 24 : 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow("Total Items:", "$totalItem", isLargeScreen),
                      SizedBox(
                        height: 8,
                        child: Divider(
                          indent: isLargeScreen ? 20 : 10,
                          endIndent: isLargeScreen ? 20 : 10,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      _buildSummaryRow("Total Price:", "\$${totalPrice.toStringAsFixed(2)}", isLargeScreen),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isLargeScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLargeScreen ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        SizedBox(width: isLargeScreen ? 240 : 180),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isLargeScreen ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: label == "Total Price:" ? Colors.green : null,
            ),
          ),
        ),
      ],
    );
  }
}
