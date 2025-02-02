class Product {
  String? id;
  String name;
  double price;

  Product({this.id, required this.name, required this.price});

  // Convert Firestore document to Product
  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id, // Assign the document ID
      name: data['name'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
    );
  }

  // Convert Product to Map for adding/updating in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
