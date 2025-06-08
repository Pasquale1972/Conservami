import 'dart:convert';

import 'package:http/http.dart' as http;

class FoodFactsService {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/api/v0/product';

  static Future<Map<String, dynamic>?> fetchProductData(String barcode) async {
    final url = Uri.parse('$_baseUrl/$barcode.json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          return data['product'] as Map<String, dynamic>;
        }
      }
    } catch (_) {
      // Ignored: network or parsing error.
    }
    return null;
  }
}
