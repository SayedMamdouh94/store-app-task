import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:store_api/model/product_model.dart';
import 'package:store_api/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiServices apiServices;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiServices = ApiServices();
  });

  group('ApiServices Tests', () {
    test('returns a list of products if the http call completes successfully', () async {
      // Arrange
      final mockResponse = jsonEncode([
        {
          "id": 1,
          "title": "Test Product",
          "price": 10.0,
          "description": "A test description",
          "category": "electronics",
          "image": "https://example.com/image.jpg",
        }
      ]);

      when(mockClient.get(Uri.parse(apiServices.productApi)))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      
      final result = await apiServices.getProducts();

     
      expect(result, isA<List<Product>>());
      expect(result.length, 1);
      expect(result.first.title, "Test Product");
    });

    test('throws an exception if the http call fails', () async {
      
      when(mockClient.get(Uri.parse(apiServices.productApi)))
          .thenAnswer((_) async => http.Response('Error', 404));

      
      expect(apiServices.getProducts(), throwsException);
    });
  });
}
