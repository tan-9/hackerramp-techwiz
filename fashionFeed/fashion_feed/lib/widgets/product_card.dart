import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;

  ProductCard({
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            productImage,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              productPrice,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Implement onPressed action (e.g., navigate to product details)
            },
            child: Text('View Details'),
          ),
        ],
      ),
    );
  }
}
