import 'package:api/api/api_servide.dart';
import 'package:api/models/product_model.dart';
import 'package:api/screens/edit_product.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final int productId;

  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchProduct(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Product not found"));
            } else {
              Product product = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(product.title, style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 8.0),
                    Text("\$${product.price}",
                        style: const TextStyle(fontSize: 20.0)),
                    const SizedBox(height: 8.0),
                    Text(product.description),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(product: product),
                          ),
                        );
                      },
                      child: const Text("Edit"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await apiService.deleteProduct(product.id!);
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
