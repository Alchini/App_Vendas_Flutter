import 'package:flutter/material.dart';
import 'package:n1_dispositivos_moveis/login.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> additionalWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    pageBuilder: (context, animation, secondaryAnimation) => Login(),
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
          Positioned(
            top: 20.0,
            right: 20.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              color: const Color.fromARGB(252, 252, 252, 252),
              onPressed: () {
                //logica do botao pa frente
              },
            ),
          ),
          Positioned(
            top: 30.0,
            left: 13.0, 
            width: 300.0,
            height: 300.0,
            child: Image.asset("assets/images/dinheiros.png"),
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
                            // logica do enviar
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
                            // logica da loja fudeu
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
        ]
      )
    );
    
  }

  @override
  void initState() {
    super.initState();
    // Adiciona os retângulos iniciais
    addRectangle();
  }

  void addRectangle() {
    setState(() {
      // Adicione um novo retângulo com as especificações desejadas
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

