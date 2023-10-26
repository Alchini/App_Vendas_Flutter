import 'package:flutter/material.dart';

class Produto1 extends StatelessWidget {
  final String productName;

  Produto1(this.productName);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Center(
        child: Text('Detalhes do produto: $productName'),
      ),
    );
  }
}
