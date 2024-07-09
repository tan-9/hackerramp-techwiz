import 'package:flutter/material.dart';
import '../widgets/product_card.dart'; // Assuming you have a ProductCard widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Feed'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommended Products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ProductCard(
              productName: 'Product 1',
              productImage: 'assets/images/product1.jpg',
              productPrice: '\$50',
            ),
            ProductCard(
              productName: 'Product 2',
              productImage: 'assets/images/product2.jpg',
              productPrice: '\$70',
            ),
            ProductCard(
              productName: 'Product 3',
              productImage: 'assets/images/product3.jpg',
              productPrice: '\$60',
            ),
            // Add more ProductCard widgets as needed
          ],
        ),
      ),
    );
  }
}
