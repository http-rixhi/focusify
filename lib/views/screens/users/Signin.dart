// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focusify/views/screens/users/Signup.dart';
import 'package:focusify/views/widgets/bottomBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                width: 400,
                height: 400,
                'assets/images/login_image.gif',
                fit: BoxFit.contain,
              ),
              Text(
                "Welcome to Concentrate+",
                style: GoogleFonts.aBeeZee(fontSize: 23),
              ),
              const SizedBox(
                height: 30,
              ),
              login_field(
                controller: _email,
                hint_text: "Enter Your Email",
                obscuretext: false,
                hide: false,
              ),
              const SizedBox(
                height: 15,
              ),
              login_field(
                controller: _password,
                hint_text: "Enter Password",
                obscuretext: true,
                hide: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Passoword ?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance.signInWithEmailAndPassword(
                        email: _email.text,
                        password: _password.text,
                      );

                      User? user = userCredential.user;
                      Toast.show('Signed in: ${user!.uid}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomBarWidget()));
                    } catch (e) {
                      Toast.show('Credentials Not Match');
                    }
                  },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, elevation: 7),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, elevation: 7),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Flexible(
                    child: Divider(
                      thickness: 0.9,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text("OR"),
                  Flexible(
                    child: Divider(
                      thickness: 0.9,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/google_img.png',
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/facebook_img.png',
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class login_field extends StatelessWidget {
  final controller;
  final String hint_text;
  final bool obscuretext;
  final bool hide;

  const login_field(
      {super.key,
      this.controller,
      required this.hint_text,
      required this.obscuretext,
      required this.hide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          hintText: hint_text,
          suffixIcon:
              hide ? const Icon(Icons.remove_red_eye) : const SizedBox(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        obscureText: obscuretext,
      ),
    );
  }
}
