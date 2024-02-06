import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/party.dart';

class PartiesListPage extends StatefulWidget {
  const PartiesListPage({super.key});

  @override
  _PartiesListPageState createState() => _PartiesListPageState();
}

class _PartiesListPageState extends State<PartiesListPage> {
  late Stream<List<Party>> partiesStream;

  @override
  void initState() {
    super.initState();
    partiesStream = FirebaseFirestore.instance
        .collection(firebaseCollections['users']!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(firebaseCollections['parties']!)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Party.fromMap(doc.data(), doc.id))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Festas'),
      ),
      body: StreamBuilder<List<Party>>(
        stream: partiesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma festa encontrada.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Party party = snapshot.data![index];
                return ListTile(
                  title: Text(party.party.name),
                  subtitle: Text('Entrou em: ${party.entryInto.toString()}'),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPartyDetailsPage(party: party),
                      ),
                    );*/
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
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateMyPartyPage()),
          );*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
