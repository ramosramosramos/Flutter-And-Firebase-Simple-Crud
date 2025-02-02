import 'package:flutter/material.dart';
import 'package:flutter_application_1/firestore_service.dart';
import 'package:flutter_application_1/product_model.dart';

class CreateProductForm extends StatefulWidget {
  @override
  _CreateProductFormState createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
      );

      try {
        await firestoreService.addProduct(product);
        Navigator.pop(context); // Go back after adding the product
      } catch (e) {
        print('Error adding product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Enter product name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter product price' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
