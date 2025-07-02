// import 'package:flutter/foundation.dart';
// import 'package:product_project_testing/model/product_model.dart';
// import 'package:product_project_testing/service/api_service.dart';


// class ProductProvider extends ChangeNotifier {
//   List<Product> products = [];
//   bool isLoading = false;

//   Future<void> loadProducts({required String search}) async {
//     isLoading = true;
//     notifyListeners();
//     products = await ApiService.fetchProducts();
//     isLoading = false;
//     notifyListeners();
//   }

//   Future<void> addProduct(Product product) async {
//     await ApiService.addProduct(product);
//     await loadProducts();
//   }

//   Future<void> updateProduct(Product product) async {
//     await ApiService.updateProduct(product);
//     await loadProducts();
//   }

//   Future<void> deleteProduct(int id) async {
//     await ApiService.deleteProduct(id);
//     await loadProducts();
//   }
//   Future<void> loadProducts({String search = ''}) async {
//   isLoading = true;
//   notifyListeners();

//   try {
//     products = await ApiService.fetchProducts(search: search);
//   } catch (e) {
//     // handle error
//   }

//   isLoading = false;
//   notifyListeners();
// }

// }
import 'package:flutter/foundation.dart';
import 'package:product_project_testing/model/product_model.dart';
import 'package:product_project_testing/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  bool isLoading = false;

  Future<void> loadProducts({String search = ''}) async {
    isLoading = true;
    notifyListeners();

    try {
      products = await ApiService.fetchProducts(search: search);
    } catch (e) {
      // Optionally handle error (e.g., clear products or show error message)
      products = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await ApiService.addProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {

    await ApiService.updateProduct(product); 
    await loadProducts();
  }


  Future<void> deleteProduct(int id) async {
    await ApiService.deleteProduct(id);
    await loadProducts();
  }
}
