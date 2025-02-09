import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/pages/cart_page.dart';
import 'package:store_api/pages/favorite_page.dart';
import 'package:store_api/provider/product_provider.dart';
import 'package:store_api/widgets/my_drawer.dart';
import 'package:store_api/widgets/product_card.dart';
import 'package:store_api/widgets/search_sort.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:store_api/provider/favorite_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
     return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        if (favoriteProvider.isLoading) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator
        }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const FavoritePage())),
            icon: const Icon(Icons.favorite),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CartPage())),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchAndSort(),
              Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return _handleProductFetch(productProvider);
                },
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
);
}

Widget _handleProductFetch(ProductProvider productProvider) {
  if (productProvider.isLoading) {
    return const Center(child: CircularProgressIndicator());
  } else if (productProvider.errorMessage != null) {
    return Center(child: Text('Error: ${productProvider.errorMessage}'));
  } else if (productProvider.products.isEmpty) {
    return const Center(child: Text('No products found'));
  } else {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the number of columns based on screen width
        int crossAxisCount = 2;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 4; // Large screens like desktop
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 3; // Tablets
        }

        return MasonryGridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return ProductCard(product: product);
          },
        );
      },
    );
  }
}}