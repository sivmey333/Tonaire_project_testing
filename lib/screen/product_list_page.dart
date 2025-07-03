import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_project_testing/provider/product_provider.dart';
import 'package:product_project_testing/screen/add_product_page.dart';
import 'package:product_project_testing/screen/edit_product_page.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isFirstLoad = true;
  late ProductProvider productProvider; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      productProvider = Provider.of<ProductProvider>(context, listen: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        productProvider.loadProducts(search: '');
      });
      _isFirstLoad = false;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    final searchText = _searchController.text.trim();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      productProvider.loadProducts(search: searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _onSearchChanged(),
              decoration: InputDecoration(
                hintText: 'Search by product name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await productProvider.loadProducts(
              search: _searchController.text.trim());
        },
        child: Consumer<ProductProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ListTile(
                  leading: product.image.isNotEmpty
                      ? Image.network(
                          product.image,
                          width: 50,
                          height: 60,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image),
                  title: Text(product.productName),
                  subtitle: Text('\$${product.price} | Stock: ${product.stock}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProductPage(product: product),
                            ),
                          );
                          if (!mounted) return;
                          await productProvider.loadProducts(
                              search: _searchController.text.trim());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content:
                                  const Text('Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true && mounted) {
                            await productProvider
                                .deleteProduct(product.productId);
                            if (!mounted) return;
                            await productProvider.loadProducts(
                                search: _searchController.text.trim());
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AddProductPage()));
          if (!mounted) return;
          await productProvider.loadProducts(
              search: _searchController.text.trim());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}