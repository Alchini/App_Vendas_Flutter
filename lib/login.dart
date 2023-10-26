import 'package:flutter/material.dart';
import 'package:n1_dispositivos_moveis/home.dart';
import 'package:n1_dispositivos_moveis/user_balance.dart';
import 'package:provider/provider.dart';




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define a paleta de cores roxa
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 30.0,
            left: 20.0,
            child: Text(
              "NTrade",
              style: TextStyle(
                fontFamily: 'AvramSans', // Use a fonte 'ProductSansRegular'
                color: Color.fromARGB(255, 134, 19, 216),
                fontSize: 18.0,
              ),
            ),
          ),
          const Positioned(
            top: 50.0,
            left: 20.0,
            child: Text(
              "Neymar \nvendeu NFT \naqui",
              style: TextStyle(
                fontFamily: 'AvramSans',
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(103, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: -45 * 3.14 / 180,
                    
                    child: const Icon(
                      Icons.nightlight_round,
                      color: Color.fromARGB(255, 128, 63, 197),
                      ),
                    ),
                    SizedBox(width: 4.0),
                    const Text(
                      "Modo escuro",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const Positioned(
            bottom: 160.0,
            left: 20.0,
            child: Text(
              "Construa o seu futuro",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
          ),
          Positioned(
            bottom: 90.0,
            left: 20.0,
            right: 40.0,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Builder(
                            builder: (context) {
                              final userBalance = Provider.of<UserBalance>(context, listen: false);
                              double saldo = userBalance.balance;
                              return HomeScreen(saldo);
                            },
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(94, 255, 255, 255),
                    foregroundColor: const Color.fromARGB(218, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Comece agora",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
       ),
      ),
    );
  }
}