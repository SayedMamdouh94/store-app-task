import 'package:flutter/material.dart';
import 'package:store_api/model/cart_model.dart';
import 'package:store_api/pages/product_detail_page.dart';
import 'package:store_api/provider/cart_provider.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
    required this.item,
    required this.cartProvider,
  });

  final CartItemData item;
  final CartProvider cartProvider;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(06),
      title: Text(
        '\$${item.product.price.toString()}',
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(04),
        child: Image.network(item.product.image, width: 50, height: 50),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildActionButton(context, '−', () {
            if (item.quantity > 1) {
              cartProvider.decreaseQuantity(item.product.id.toString());
            } else {
              cartProvider.removeFromCart(item.product.id.toString());
            }
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${item.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          _buildActionButton(context, '+', () {
            if (item.quantity > 0) {
              cartProvider.increaseQuantity(item.product.id.toString());
            }
          }),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => cartProvider.removeFromCart(
              item.product.id.toString(),
            ),
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.remove_circle,
              ),
            ),
          ),
        ],
      ),
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: item.product))),
    );
  }

//quantity
  Widget _buildActionButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: text == '+' ? 40 : 44,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
