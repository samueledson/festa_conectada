import 'package:festa_conectada/src/enums/my_party_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/my_party.dart';

class CreateMyPartyPage extends StatefulWidget {
  const CreateMyPartyPage({super.key});

  @override
  _CreateMyPartyPageState createState() => _CreateMyPartyPageState();
}

class _CreateMyPartyPageState extends State<CreateMyPartyPage> {
  TextEditingController partyNameController = TextEditingController();

  Future<void> createParty() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Crie uma nova festa usando o modelo de dados
      MyParty newParty = MyParty(
        id: '',
        name: partyNameController.text,
        status: MyPartyStatus.active,
        createdAt: DateTime.now(),
      );

      // Adicione a nova festa ao Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('parties')
          .add(newParty.toMap())
          .then((value) {
            // Exiba uma mensagem de sucesso
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Festa criada com sucesso!'),
              ),
            );

            // Limpe o campo de texto
            partyNameController.clear();
          })
          .catchError((err) {
            // Se o cadastro falhar, exiba uma mensagem de erro.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(err.toString()),
              ),
            );
          });
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao criar a festa: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Festa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: partyNameController,
              decoration: const InputDecoration(labelText: 'Nome da Festa'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createParty,
              child: const Text('Criar Festa'),
            ),
          ],
        ),
      ),
    );
  }
}
