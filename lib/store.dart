import 'package:flutter/material.dart';
import 'package:n1_dispositivos_moveis/home.dart';
import 'package:n1_dispositivos_moveis/user_balance.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreScreen(),
    );
  }
}

class Product {
  final String image;
  final String name;
  final double price;
  final String descricao;

  Product(this.image, this.name, this.price, this.descricao);
}

class StoreScreen extends StatelessWidget {
  final List<Product> products = [
    Product('assets/images/produtos/1.png', 'Trinta e Doze', 10.0, 'teste caralho'),
    Product('assets/images/produtos/2.jpg', 'Cigarro Quente', 10.0, 'teste caralho'),
    Product('assets/images/produtos/3.png', 'FLDSDMRF', 10.0, 'teste caralho'),
    Product('assets/images/produtos/4.jpg', 'Urânio', 10.0, 'teste caralho'),
    Product('assets/images/produtos/5.png', 'AWP Salsicha', 10.0, 'teste caralho'),
    Product('assets/images/produtos/6.jpg', 'Arma do SENAI', 10.0, 'teste caralho'),
    Product('assets/images/produtos/7.jpg', 'Coca Seminova', 10.0, 'teste caralho'),
    Product('assets/images/produtos/8.jpg', 'Narga do Drake', 10.0, 'teste caralho'),
    // Pra adicionar mais produto é só ir metendo ai
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 62, 99),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  final userBalance = Provider.of<UserBalance>(context, listen: false);
                  double saldo = userBalance.balance;
                  return HomeScreen(saldo,);
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index], productIndex: index);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard({required this.product, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ProductScreen(product: product);
          },
        ));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              product.image,
              width: 150,
              height: 150,
            ),
          ),
          Text(
            product.name,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final Product product;

  ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(product.image, width: 200, height: 200),
            Text(
              product.name,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            // Adicione outros detalhes do produto conforme necessário
          ],
        ),
      ),
    );
  }
}
