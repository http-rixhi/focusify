// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focusify/views/widgets/Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                //     child: Text(
                //       "Focusify",
                //       style: GoogleFonts.aboreto(fontSize: 40),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: "What You Want to learn ?",
                      hintStyle: TextStyle(color: tealLevel5),
                      suffixIcon: Icon(
                        Icons.search,
                        color: tealLevel3,
                      ),
                      focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tealLevel3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
