import 'package:flutter/material.dart';
import 'package:product_project_testing/provider/product_provider.dart';
import 'package:product_project_testing/screen/product_list_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product CRUD',
      home: const ProductListPage(),
    );
  }
}
