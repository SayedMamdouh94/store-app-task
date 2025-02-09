import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:store_api/provider/favorite_provider.dart';
import 'favorite_provider_test.mocks.dart'; // Ensure correct file name

@GenerateMocks([Box]) // Generates a mock class for Box<int>
void main() {
  late FavoriteProvider favoriteProvider;
  late MockBox<int> mockBox;

  setUp(() {
    mockBox = MockBox<int>(); // Mock Hive Box
    favoriteProvider = FavoriteProvider(box: mockBox); // Inject mock box
  });

  group('FavoriteProvider Tests', () {
    test('Should initialize correctly', () async {
      when(mockBox.keys).thenReturn({1, 2, 3}); // Mock stored keys
      await favoriteProvider.init();
      expect(favoriteProvider.isLoading, false);
    });

    test('Should add item to favorites when not already favorited', () {
      when(mockBox.containsKey(1)).thenReturn(false);
      favoriteProvider.toggleFavorite(1);
      verify(mockBox.put(1, 1)).called(1);
    });

    test('Should remove item from favorites when already favorited', () {
      when(mockBox.containsKey(1)).thenReturn(true);
      favoriteProvider.toggleFavorite(1);
      verify(mockBox.delete(1)).called(1);
    });

    test('Should return true for favorite items', () {
      when(mockBox.containsKey(2)).thenReturn(true);
      expect(favoriteProvider.isFavorite(2), isTrue);
    });

    test('Should return false for non-favorite items', () {
      when(mockBox.containsKey(5)).thenReturn(false);
      expect(favoriteProvider.isFavorite(5), isFalse);
    });

    test('Should clear all favorite items', () {
      favoriteProvider.removeAllFromFavorite();
      verify(mockBox.clear()).called(1);
    });
  });
}
