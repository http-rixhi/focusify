import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:concentrate_plus/views/widgets/dnd_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  get data => null;

  // Personal Details
  final _picker = ImagePicker();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _dob = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  // Educational Details
  final _college = TextEditingController();
  final _studyField = TextEditingController();
  final _interest = TextEditingController();
  // final Otp = TextEditingController();

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
                  style: GoogleFonts.aBeeZee(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Personal Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: _name,
                  hint_text: "What's Your Name ",
                  obscuretext: false,
                  SendButton: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: _phone,
                  hint_text: "Phone Number ",
                  obscuretext: false,
                  SendButton: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: TextField(
                    controller: _dob,
                    decoration: InputDecoration(
                        labelText: "Date of birth",
                        hintText: "dob",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5))),
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)))!;
                      _dob.text = date.toIso8601String();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                login_field(
                  controller: _email,
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
                  height: 45,
                ),
                Text(
                  'Educational Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                    controller: _studyField,
                    hint_text: 'Field of Study (*Optional*)',
                    obscuretext: false,
                    SendButton: false),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                    controller: _college,
                    hint_text: 'Name of School/College',
                    obscuretext: false,
                    SendButton: false),
                const SizedBox(
                  height: 15,
                ),
                login_field(
                    controller: _interest,
                    hint_text: "What's your interest (*Optional*)",
                    obscuretext: false,
                    SendButton: false),
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
                        if (_name.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Name field is required*",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        } else if (_phone.text.isEmpty ||
                            _phone.text.length != 10) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Phone Number is empty or incorrect",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          ));
                        } else if (_dob.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("DOB field is required"),
                          ));
                        } else if (_email.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Email field is required",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          ));
                        } else if (_password.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password field is required",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          ));
                        } else if (_password.text.length != 8) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Password must be atleast of 8 digits'),
                            backgroundColor: Colors.red,
                          ));
                        } else if (_college.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("College name is required",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red,
                          ));
                        }
                        if (_name.text.isNotEmpty &&
                            _phone.text.isNotEmpty &&
                            _email.text.isNotEmpty &&
                            _password.text.isNotEmpty &&
                            _dob.text.isNotEmpty &&
                            _college.text.isNotEmpty) {
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _email.text,
                              password: _password.text,
                            );
                            showEmailNotExistSnackBar(
                                context, "Account Created successfully");

                            // Storing data in Firestore
                            _firestore.collection("User Details").add({
                              "Date": DateTime.now(),
                              "Name": _name.text,
                              "Phone": _phone.text,
                              "Email": _email.text,
                              "Date of Birth": _dob.text,
                              "Profile pic": _picker.toString()
                            });

                            // Successfully created a user, navigate to the HomeScreen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DndPopup(),
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
                        } else {
                          // SnackBar(content: Text('Fill all Details'));
                          Toast.show('Fill all Details');
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
