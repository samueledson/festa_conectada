import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/my_party.dart';
import 'create_my_party_page.dart';
import 'my_party_details_page.dart';

class MyPartiesListPage extends StatefulWidget {
  const MyPartiesListPage({super.key});

  @override
  _MyPartiesListPageState createState() => _MyPartiesListPageState();
}

class _MyPartiesListPageState extends State<MyPartiesListPage> {
  late Stream<List<MyParty>> partiesStream;

  @override
  void initState() {
    super.initState();
    partiesStream = FirebaseFirestore.instance
        .collection(firebaseCollections['users']!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(firebaseCollections['myParties']!)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MyParty.fromMap(doc.data(), doc.id))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Festas'),
      ),
      body: StreamBuilder<List<MyParty>>(
        stream: partiesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma festa sua encontrada.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MyParty party = snapshot.data![index];
                return ListTile(
                  title: Text(party.name),
                  subtitle: Text('Criada em: ${party.createdAt.toString()}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPartyDetailsPage(party: party),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a página de criação de festas
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateMyPartyPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
