import 'dart:convert';
import 'package:api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Fetch all products from the API
  Future<List<Product>> fetchAllProducts() async {
    const String url = "https://fakestoreapi.com/products";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        List<Product> products = responseData.map((json) {
          return Product.fromJson(json);
        }).toList();
        return products;
      } else {
        print("Failed to fetch products. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to fetch products");
    }
  }

  // Fetch a single product from the API
  Future<Product> fetchProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Product product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to fetch product");
    }
  }

  // Add a product to the API
  Future<Product> addProduct(Product product) async {
    const String url = "https://fakestoreapi.com/products";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Product newProduct = Product.fromJson(json.decode(response.body));
        // Print the full response
        print("Response body: ${response.body}");
        return newProduct;
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to add product");
    }
  }

  // Update a product in the API
  Future<Product> updateProduct(int id, Product product) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200) {
        Product updatedProduct = Product.fromJson(json.decode(response.body));
        // Print the full response
        print("Response body: ${response.body}");
        return updatedProduct;
      } else {
        print("Failed to update product. Status code: ${response.statusCode}");
        throw Exception("Failed to update product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to update product");
    }
  }

  // Delete a product from the API
  Future<void> deleteProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.delete(Uri.parse(url));

      print("Response status code: ${response.statusCode}");
      // Print the body of the response
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        print("Failed to delete product. Status code: ${response.statusCode}");
        throw Exception("Failed to delete product");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to delete product");
    }
  }
}
