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
      home: Sold(),
    );
  }
}



class Sold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(22, 48, 81, 1),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: const Color.fromARGB(252, 252, 252, 252),
              onPressed: () { 
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      final userBalance = Provider.of<UserBalance>(context, listen: false);
                      double saldo = userBalance.balance;
                      return HomeScreen(saldo);
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // aqui ta sendo definida a posição inicial da tela
                      const end = Offset.zero; // aqui é a posição final da tela
                      const curve = Curves.easeInOut; // aqui ele define uma curva?? pra animação

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  )
                );
              },
            ),
          ),
          const Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          // Mensagem "parabéns!" na cor roxa
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Parabéns!",
                style: TextStyle(
                  color: Color.fromARGB(255, 123, 31, 203),
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // Imagem no centro
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/MoneyTag.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          // Texto pequeno em branco
          const Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Você vendeu seu item!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 215,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "\$450.03",
                style: TextStyle(
                  color: Color.fromARGB(255, 123, 31, 203),
                  fontSize: 36,
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Grafico.png', 
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            top: 420,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "JAN            FEV            MAR            ABR            MAI", //Não é a melhor maneira mas é isso o que temos pra hoje
                style: TextStyle(
                  color: Color.fromARGB(255, 157, 157, 157),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          // mas é uma bolinha normal ou é uma bolinha guei?
          Positioned(
            top: 400,
            left: 268, 
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 128, 33, 243),
              ),
            ),
          ),
          Positioned(
            top: 480,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(54,79,161,255),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vendas de hoje",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$539.10",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 24
                          ),
                      ),
                      Spacer(),
                      Text(
                        "5.3%",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 15
                          ),
                      ),
                      Icon(Icons.trending_up, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}






