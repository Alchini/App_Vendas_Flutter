import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:n1_dispositivos_moveis/firebase_options.dart';
import 'package:n1_dispositivos_moveis/home.dart';
import 'package:n1_dispositivos_moveis/transfer.dart';
import 'package:n1_dispositivos_moveis/user_balance.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Send(),
      ),
    );
  }
}

class Send extends StatefulWidget {
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  final firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  List<String> contacts = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> addContactToFirestore(String name) async {
    print('Tentando adicionar um contato com o nome: $name');
    try {
      await firestore.collection('contacts').add({
        'name': name,
      });
      setState(() {
        contacts.add(name);
      });
    } catch (e) {
      print('Erro ao adicionar contato: $e');
    }
  }

  Stream<QuerySnapshot> getContactsFromFirestore() {
    return firestore.collection('contacts').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            final userBalance = Provider.of<UserBalance>(context, listen: false);
                            double saldo = userBalance.balance;
                            return HomeScreen(saldo);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(
                    "Adicione um contato ou selecione um contato salvo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 74, 41, 194),
                        width: 2,
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nome',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final contactName = nameController.text;
                    if (contactName.isNotEmpty) {
                      addContactToFirestore(contactName);
                      nameController.clear();
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 74, 41, 194),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Contatos salvos",
                  style: TextStyle(
                    color: Colors.white, // Altera a cor para branca
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: getContactsFromFirestore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('Nenhum contato encontrado.');
                      }
                      final contactsData = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: contactsData.length,
                        itemBuilder: (context, index) {
                          final contact = contactsData[index];
                          final contactName = contact['name'] ?? '';

                          return CustomListItem(
                            contactName: contactName,
                            onSendPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TransferScreen()));
                            },
                            onDeletePressed: () {
                              contact.reference.delete();
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final String contactName;
  final VoidCallback onSendPressed;
  final VoidCallback onDeletePressed;

  CustomListItem({
    required this.contactName,
    required this.onSendPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0), // Adiciona espaço à esquerda
              child: Text(
                contactName,
                style: TextStyle(
                  color: Colors.white, // Altera a cor para branca
                  fontSize: 16.0, // Altera o tamanho da fonte
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onSendPressed,
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18, // Defina o tamanho desejado
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 18, // Defina o tamanho desejado
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
