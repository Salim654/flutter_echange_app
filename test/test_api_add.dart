import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_simple_page/Services/ApiClient.dart';

void main() {
  group('ApiClient addProduct', () {
    test('should add a product successfully', () async {
      
      final String nomProduit = 'Test new Product';
      final String description = 'Testnew  Description';
      final int categorieId = 2;
      final String token = '56|hz7FSdPjIcO5PNODUQZjqU2HSS0bSGaaoDaZKcIbc7ae1252';
      final String iduser = '5';

      
      final http.Response response = await ApiClient.addProduct(
        nomProduit: nomProduit,
        description: description,
        categorieId: categorieId,
        token: token,
        iduser: iduser,
      );
      expect(response.statusCode, 201);
      
    });
  });
}
