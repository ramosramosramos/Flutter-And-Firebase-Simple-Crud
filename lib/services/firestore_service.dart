import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference products = FirebaseFirestore.instance.collection('products');

  // Read all products
  Stream<List<Product>> getProducts() {
    return products.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Add product
  Future<void> addProduct(Product product) async {
    try {
      // Add product and get the document reference
      var docRef = await _db.collection('products').add({
        'name': product.name,
        'price': product.price,
      });
      
      // After the product is added, update the product model with the assigned document ID
      product.id = docRef.id;
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  // Update product
  Future<void> updateProduct(Product product) async {
    try {
      if (product.id != null) {
        await _db.collection('products').doc(product.id).update({
          'name': product.name,
          'price': product.price,
        });
      } else {
        print("Product ID is missing. Cannot update.");
      }
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection('products').doc(productId).delete();
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }
}
