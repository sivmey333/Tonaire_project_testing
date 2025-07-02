import 'package:flutter/material.dart';
import 'package:product_project_testing/model/product_model.dart';
import 'package:product_project_testing/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '', image = '';
  double price = 0;
  int stock = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name',
                border: OutlineInputBorder(),
                ),
                onSaved: (v) => name = v ?? '',
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price',
                border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (v) => price = double.tryParse(v ?? '0') ?? 0,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stock',
                border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (v) => stock = int.tryParse(v ?? '0') ?? 0,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL',
                border: OutlineInputBorder(),
                ),
                onSaved: (v) => image = v ?? '',
              ),
              const SizedBox(height: 20),
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
                    await provider.addProduct(Product(
                      productId: 0,
                      productName: name,
                      price: price,
                      stock: stock,
                      image: image,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
