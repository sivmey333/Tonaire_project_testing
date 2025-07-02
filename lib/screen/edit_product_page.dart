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
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Product Name',
                border: OutlineInputBorder(),
                ),
                onSaved: (v) => name = v ?? '',
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price',
                border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (v) => price = double.tryParse(v ?? '0') ?? 0,
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: stock.toString(),
                decoration: const InputDecoration(labelText: 'Stock',
                border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (v) => stock = int.tryParse(v ?? '0') ?? 0,
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(labelText: 'Image URL',
                border: OutlineInputBorder(),
                ),
                onSaved: (v) => image = v ?? '',
              ),
              SizedBox(height: 20,),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState!.save();
                    await provider.updateProduct(Product(
                      productId: widget.product.productId,
                      productName: name,
                      price: price,
                      stock: stock,
                      image: image,
                    ));
                    Navigator.pop(context);
                  },
                  child: const Text('Save Changes'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
