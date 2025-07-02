import 'package:flutter/material.dart';
import 'package:product_project_testing/model/product_model.dart';
import 'package:product_project_testing/provider/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  final Product product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, image;
  late double price;
  late int stock;

  @override
  void initState() {
    super.initState();
    name = widget.product.productName;
    price = widget.product.price;
    stock = widget.product.stock;
    image = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Name
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter product name' : null,
                onSaved: (v) => name = v ?? '',
              ),
              const SizedBox(height: 20),

              // Price
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter price';
                  if (double.tryParse(value) == null) return 'Invalid price';
                  return null;
                },
                onSaved: (v) => price = double.tryParse(v ?? '0') ?? 0,
              ),
              const SizedBox(height: 20),

              // Stock
              TextFormField(
                initialValue: stock.toString(),
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter stock';
                  if (int.tryParse(value) == null) return 'Invalid stock';
                  return null;
                },
                onSaved: (v) => stock = int.tryParse(v ?? '0') ?? 0,
              ),
              const SizedBox(height: 20),

              // Image
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter image URL' : null,
                onSaved: (v) => image = v ?? '',
              ),
              const SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                 textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await provider.updateProduct(Product(
                        productId: widget.product.productId,
                        productName: name,
                        price: price,
                        stock: stock,
                        image: image,
                      ));
                      print('Update successful');
                      Navigator.pop(context);
                    } catch (e) {
                      print('Update failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Update failed: $e')),
                      );
                    }
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
