<!-- # product_project_testing

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. -->
# Flutter + Express.js + MySQL Product CRUD App

This is a full-stack product crud app built with:

- 📱 **Flutter** (with Provider) for the frontend
- 🌐 **Express.js** for the RESTful API backend
- 🛢️ **MySQL** as the database (I used macbook. so, it's difficult to use with SQL server. And then, I decided use MySQL as Database)
- **Running** run with IOS simulator using my mac ip
- **Api Url**('http://my_mac_ip:3000/products')

## 🗂️ Project Structure
product_project_testing/
├── product-crud-app/backend/ # Node.js + Express API
                            ├── index.js
                            ├── .env
├── lib/ # Flutter app (iOS/Android)
        ├── model/product_model.dart
        ├── service/ api_service.dart
        ├── database/database.spl 
        ├── main.dart
        ├── provider/product_provider.dart 
        ├── screen/ 
            ├── product_list_page.dart
            ├── add_product_page.dart
            ├── edit_product_page.dart
├── README.md # You're here