import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_api/pages/home_page.dart';
import 'package:store_api/provider/cart_provider.dart';
import 'package:store_api/provider/favorite_provider.dart';
import 'package:store_api/provider/product_provider.dart';
import 'package:store_api/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //  Ensuring Flutter bindings are initialized

  await Hive.initFlutter(); //  Initialize Hive before opening boxes
  await Hive.openBox<int>('favorites'); //  Ensure this is completed before running the app

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()..init()), //  Initialize FavoriteProvider correctly
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App Task',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
