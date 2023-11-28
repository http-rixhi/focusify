import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focusify/views/screens/bottombar/home_screen.dart';
import 'package:focusify/views/screens/users/Signin.dart';
import 'package:focusify/views/widgets/models.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _username = TextEditingController();
  final Name = TextEditingController();
  final _password = TextEditingController();
  final Otp = TextEditingController();

  void showEmailNotExistSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: message == "Account Created successfully"
              ? const TextStyle(color: Colors.green)
              : const TextStyle(color: Colors.red),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  "Join Our Family",
                  style: GoogleFonts.aBeeZee(fontSize: 23),
                ),
                const SizedBox(
                  height: 30,
                ),
                login_field(
                  controller: Name,
                  hint_text: "What's Your Name ",
                  obscuretext: false,
                  SendButton: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: _username,
                  hint_text: "Enter Your Email",
                  obscuretext: false,
                  SendButton: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: _password,
                  hint_text: "Create Your Password",
                  obscuretext: true,
                  SendButton: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: Otp,
                  hint_text: "OTP",
                  obscuretext: false,
                  SendButton: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 7),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _username.text,
                            password: _password.text,
                          );
                          showEmailNotExistSnackBar(
                              context, "Account Created successfully");
                          // Successfully created a user, navigate to the HomeScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            // Handle the case where the email is already in use
                            showEmailNotExistSnackBar(
                                context, "Email is already in use.");
                          } else {
                            // Handle other authentication-related errors
                            showEmailNotExistSnackBar(
                                context, "An error occurred: ${e.message}");
                          }
                        } catch (e) {
                          // Handle other generic errors
                          showEmailNotExistSnackBar(
                              context, "An error occurred: $e");
                        }
                      },
                    ))
              ]),
        ),
      ),
    );
  }
}

class login_field extends StatelessWidget {
  final controller;
  final String hint_text;
  final bool obscuretext;
  final bool SendButton;

  const login_field(
      {super.key,
      this.controller,
      required this.hint_text,
      required this.obscuretext,
      required this.SendButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(),
          suffixIcon: SendButton == true
              ? const Icon(Icons.send_rounded)
              : const SizedBox(),
          hintText: hint_text,
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
