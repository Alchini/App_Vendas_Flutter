import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:n1_dispositivos_moveis/home.dart';
import 'package:n1_dispositivos_moveis/send.dart';
import 'package:n1_dispositivos_moveis/user_balance.dart';
import 'package:provider/provider.dart';

final databaseReference = FirebaseDatabase.instance.ref();


class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController textEditingController = TextEditingController();
  double saldo = 2.3;
  bool showLoading = false;

Future<void> updateBalance(double newBalance) async {
  final userBalanceReference = FirebaseFirestore.instance.collection("user_balance");
  
  // Você precisa de um identificador único para o documento, aqui usarei "user_balance_document".
  final documentReference = userBalanceReference.doc("user_balance_document");

  await documentReference.set({"saldo": newBalance});
}

void showLoadingScreen() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: SimpleDialog(
          children: [
            Column(
              children: [
                SpinKitFadingCircle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  size: 50.0,
                ),
                SizedBox(height: 20),
                Text(
                  "Enviando...",
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );

  double valorTransferencia = double.parse(textEditingController.text);
  final userBalance = Provider.of<UserBalance>(context, listen: false);

  double novoSaldo = saldo - valorTransferencia;

  try {
    // Atualize o saldo no Firebase Firestore
    await updateBalance(novoSaldo);

    // Atualize o saldo localmente
    setState(() {
      saldo = novoSaldo;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      // Após o término da operação, você pode navegar para a tela inicial
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(novoSaldo)));
    });
  } catch (error) {
    // Lida com erros na atualização do Firebase, se necessário
    print("Erro ao atualizar o saldo: $error");
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background com imagem local
          Image.asset(
            'assets/images/background2.png', // Substitua pelo caminho da sua imagem
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Botão de voltar no canto superior esquerdo
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Send()));;
              },
              color: Colors.white,
            ),
          ),
          // Conteúdo da tela
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Espaço vazio no topo
              SizedBox(height: 40),
              // Texto "Qual é o valor da transferência?"
              Text(
                'Qual é o valor da transferência?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              // Espaço vazio
              SizedBox(height: 20),
              // Texto "Saldo disponível em conta:"
              Text(
                'Saldo disponível em conta:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              // Espaço entre o texto "Saldo disponível em conta" e o campo de entrada
              SizedBox(height: 20),
              // Campo de entrada de texto (linha roxa) com "R$" à esquerda
              Container(
                width: 200, // Largura desejada
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: const Color.fromARGB(255, 74, 41, 194), width: 2)),
                ),
                child: Row(
                  children: [
                    Text(
                      'R\$ ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Botão redondo com ícone de enviar à direita
                    GestureDetector(
                      onTap: () {
                        showLoadingScreen();
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 74, 41, 194),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // GIF de loading
              if (showLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
