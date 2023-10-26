import 'package:flutter/material.dart';
import 'package:n1_dispositivos_moveis/firebase_options.dart';
import 'package:n1_dispositivos_moveis/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:n1_dispositivos_moveis/user_balance.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserBalance()),
      ],
      child: MaterialApp(
        home: Builder( // Adicione um Builder aqui
          builder: (context) {
            return Login();
          },
        ),
      ),
    ),
  );
}