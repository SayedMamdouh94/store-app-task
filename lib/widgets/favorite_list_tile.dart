import 'package:flutter/material.dart';
import 'package:store_api/model/product_model.dart';
import 'package:store_api/pages/product_detail_page.dart';
import 'package:store_api/provider/favorite_provider.dart';

class FavoriteCartTile extends StatelessWidget {
  const FavoriteCartTile({
    super.key,
    required this.products,
    required this.favoriteProvider,
  });

  final Product products;
  final FavoriteProvider favoriteProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(06),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${products.price.toStringAsFixed(2)}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Text(
            'Rating: ${products.rating.rate}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
      leading: Image(
        height: 50,
        width: 50,
        image: NetworkImage(
          products.image,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          favoriteProvider.toggleFavorite(products.id);
        },
        icon: const Icon(
          Icons.remove_circle,
        ),
      ),
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: products))),
    );
  }
}
