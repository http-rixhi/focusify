// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focusify/firebase_options.dart';
import 'package:focusify/views/screens/users/Signin.dart';
import 'package:focusify/views/widgets/dnd_popup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SignInScreen()
            )
        )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
    StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    return const DndPopup();
    } else {
    return const SignInScreen();
    }
    })
        ],
      ),

    );
  }
}
