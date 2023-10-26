import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:n1_dispositivos_moveis/login.dart';
import 'package:n1_dispositivos_moveis/send.dart';
import 'package:n1_dispositivos_moveis/sold.dart';
import 'package:n1_dispositivos_moveis/store.dart';

final databaseReference = FirebaseDatabase.instance.ref();

class MyApp extends StatelessWidget {
  final double novoSaldo;

  MyApp(this.novoSaldo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(novoSaldo),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final double novoSaldo;

  HomeScreen(this.novoSaldo);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double saldo = 2.3;

  @override
  void initState() {
    super.initState();
    fetchBalance();
  }

 void fetchBalance() async {
  final userBalanceReference =
      FirebaseFirestore.instance.collection("user_balance");
  final documentReference = userBalanceReference.doc("user_balance_document");

  final snapshot = await documentReference.get();
  if (snapshot.exists) {
    final data = snapshot.data();
    final balance = data?["saldo"] as double;
    setState(() {
      saldo = balance;
    });
  }
}


  List<Widget> additionalWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 20.0,
        left: 20.0,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromARGB(252, 252, 252, 252),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Login(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0,
                        0.0); // aqui ta sendo definida a posição inicial da tela
                    const end = Offset.zero; // aqui é a posição final da tela
                    const curve = Curves
                        .easeInOut; // aqui ele define uma curva?? pra animação

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ));
          },
        ),
      ),
      Positioned(
        top: 20.0,
        right: 20.0,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          color: const Color.fromARGB(252, 252, 252, 252),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Sold(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0,
                        0.0); // aqui ta sendo definida a posição inicial da tela
                    const end = Offset.zero; // aqui é a posição final da tela
                    const curve = Curves
                        .easeInOut; // aqui ele define uma curva?? pra animação

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ));
          },
        ),
      ),
      Positioned(
        top: 30.0,
        left: 13.0,
        width: 300.0,
        height: 300.0,
        child: Stack(
          children: [
            Image.asset("assets/images/dinheiros.png"),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${saldo.toStringAsFixed(1)}K",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 350.0,
        left: 20.0,
        right: 20.0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 74, 41, 194),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Send()));
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Enviar",
                      style: TextStyle(
                        color: Color.fromARGB(148, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 74, 41, 194),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        color: Colors.white,
                        onPressed: () {
                          // logica do recebakkkk bora biu kkk memes
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Receber",
                      style: TextStyle(
                        color: Color.fromARGB(148, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 74, 41, 194),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => StoreScreen()));
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Loja",
                      style: TextStyle(
                        color: Color.fromARGB(148, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 74, 41, 194),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.bookmark),
                        color: Colors.white,
                        onPressed: () {
                          // logica wishlist games foda
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "Wishlist",
                      style: TextStyle(
                        color: Color.fromARGB(148, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    "Seu histórico de transações",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: additionalWidgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return additionalWidgets[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }

  void addRectangle() {
    setState(() {
      additionalWidgets.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Row(
            children: [
              Text(
                "RS dinheiros",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Icon(
                Icons.file_upload,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    });
  }
}
