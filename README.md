# Flutter API Basics - DP Education

This Dart package provides a simple API service for interacting with a mock store API (`https://fakestoreapi.com`). It includes methods for fetching all products, fetching a single product, adding a product, updating a product, and deleting a product.

## Installation

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  http: ^0.13.3
```

## Usage

### Importing the ApiService

```dart
import 'package:api/api_service.dart';
import 'package:api/models/product_model.dart';
```

### Fetching All Products

```dart
final apiService = ApiService();

apiService.fetchAllProducts().then((products) {
  products.forEach((product) {
    print(product.title);
  });
}).catchError((error) {
  print("Error fetching products: $error");
});
```

### Fetching a Single Product

```dart
final int productId = 1; // Replace with the desired product ID

apiService.fetchProduct(productId).then((product) {
  print(product.title);
}).catchError((error) {
  print("Error fetching product: $error");
});
```

### Adding a Product

```dart
final Product newProduct = Product(
  title: "New Product",
  price: 19.99,
  description: "This is a new product",
  category: "electronics",
  image: "https://example.com/image.jpg",
);

apiService.addProduct(newProduct).then((product) {
  print("Added product: ${product.title}");
}).catchError((error) {
  print("Error adding product: $error");
});
```

### Updating a Product

```dart
final int productId = 1; // Replace with the desired product ID
final Product updatedProduct = Product(
  id: productId,
  title: "Updated Product",
  price: 29.99,
  description: "This is an updated product",
  category: "electronics",
  image: "https://example.com/image.jpg",
);

apiService.updateProduct(productId, updatedProduct).then((product) {
  print("Updated product: ${product.title}");
}).catchError((error) {
  print("Error updating product: $error");
});
```

### Deleting a Product

```dart
final int productId = 1; // Replace with the desired product ID

apiService.deleteProduct(productId).then(() {
  print("Product deleted");
}).catchError((error) {
  print("Error deleting product: $error");
});
```

## Error Handling

Each method includes basic error handling that prints error messages to the console. You can customize this behavior as needed for your application.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit pull requests and issues. For major changes, please open an issue first to discuss what you would like to change.

## Acknowledgements

- [Fake Store API](https://fakestoreapi.com) for providing a simple API for testing and prototyping.
- The Dart and Flutter communities for their continuous support and contributions.
