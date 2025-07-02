import 'package:flutter/foundation.dart';
import 'package:product_project_testing/model/product_model.dart';
import 'package:product_project_testing/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  void _safeNotifyListeners() {
    try {
      notifyListeners();
    } catch (e) {
      debugPrint('notifyListeners error: $e');
    }
  }

  Future<void> loadProducts({String search = ''}) async {
    isLoading = true;
    _safeNotifyListeners();

    try {
      products = await ApiService.fetchProducts(search: search);
    } catch (e) {
      debugPrint('Error loading products: $e');
      products = [];
    }

    isLoading = false;
    _safeNotifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      await ApiService.addProduct(product);
      await loadProducts();
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await ApiService.updateProduct(product);
      await loadProducts();
    } catch (e) {
      debugPrint('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      await loadProducts();
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }
}
