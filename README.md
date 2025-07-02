
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