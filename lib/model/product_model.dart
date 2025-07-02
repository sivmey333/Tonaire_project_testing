class Product {
  final int productId;
  final String productName;
  final double price;
  final int stock;
  final String image;

  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.stock,
    required this.image,
  });

 factory Product.fromJson(Map<String, dynamic> json) => Product(
  productId: json['productId'] ?? 0,
  productName: json['productName'] ?? '',
  price: (json['price'] is String)
      ? double.parse(json['price'])
      : (json['price'] != null ? (json['price'] as num).toDouble() : 0.0),
  stock: json['stock'] ?? 0,
  image: json['image'] ?? '',
);


  Map<String, dynamic> toJson() => {
        'productName': productName,
        'price': price,
        'stock': stock,
        'image': image,
      };
}
