
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_project_testing/model/product_model.dart';

const String baseUrl = 'http://192.168.3.187:3000/products';

class ApiService {
  static Future<List<Product>> fetchProducts({String search = ''}) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {
      if (search.isNotEmpty) 'search': search,
    });

    final res = await http.get(uri);

    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<void> deleteProduct(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }

  static Future<void> addProduct(Product product) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
  }

  static Future<void> updateProduct(Product product) async {
  final response = await http.put(
    Uri.parse('$baseUrl/${product.productId}'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(product.toJson()),
  );

  print('Update API response: ${response.statusCode} | ${response.body}');

  if (response.statusCode != 204) {
    throw Exception('Failed to update product: ${response.body}');
  }
}



  static Future<Product> getProduct(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/$id'));
    return Product.fromJson(json.decode(res.body));
  }
}
