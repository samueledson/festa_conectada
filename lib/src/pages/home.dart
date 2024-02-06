import 'package:festa_conectada/src/pages/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_parties/my_parties_list_page.dart';
import 'parties/parties_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? "https://th.bing.com/th/id/OIP.DfbvP4LXGsNlhGino3DA6QHaHa?rs=1&pid=ImgDetMain"),
                    radius: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? "Samuel Edson",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    FirebaseAuth.instance.currentUser?.email ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Painel'),
              onTap: () {
                // Navegar para a página inicial (home)
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Festas'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PartiesListPage())
                );
              },
            ),
            ListTile(
              title: const Text('Minhas Festas'),
              onTap: () {
                // Navegar para a página festas
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPartiesListPage())
                );
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                // Fazer logout
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bem-vindo à Festa Conectada!'),
      ),
    );
  }
}