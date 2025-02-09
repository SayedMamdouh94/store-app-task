import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoriteProvider extends ChangeNotifier {
  late Box<int> _favoritesBox;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  Set<int> get favoriteProducts => _favoritesBox.keys.cast<int>().toSet();

  FavoriteProvider({Box<int>? box}) {
    if (box != null) {
      _favoritesBox = box; // Allow injection for testing
      _isLoading = false;
    }
  }

  Future<void> init() async {
    _favoritesBox = await Hive.openBox<int>('favorites'); 
    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int productId) {
    if (_favoritesBox.containsKey(productId)) {
      _favoritesBox.delete(productId);
    } else {
      _favoritesBox.put(productId, productId);
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favoritesBox.containsKey(productId);
  }

  void removeAllFromFavorite() {
    _favoritesBox.clear();
    notifyListeners();
  }
}
