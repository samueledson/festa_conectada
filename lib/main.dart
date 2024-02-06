import 'package:festa_conectada/src/pages/home.dart';
import 'package:festa_conectada/src/pages/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FestaConectadaApp());
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Verifique se o usuário está logado enquanto aguarda uma conexão.
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // O usuário está autenticado, vá para a página home.
          if (kDebugMode) {
            print(snapshot.data?.uid);
          }
          return const HomePage();
        } else {
          // O usuário não está autenticado, vá para a página de login.
          return const SignInPage();
        }
      },
    );
  }
}

class FestaConectadaApp extends StatelessWidget {
  const FestaConectadaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Festa Conectada',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const AuthenticationWrapper(),
  );
}