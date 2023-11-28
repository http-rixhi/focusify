import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focusify/views/screens/bottombar/content.dart';
import 'package:focusify/views/widgets/Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Images = [
    "https://imgs.search.brave.com/G1qVWcisjEs-v4rqv6ZMrbpJqhL37iDShXoZdnlqXdQ/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zZW5q/YWlvLmItY2RuLm5l/dC9wdWJsaWMvbWVk/aWEvOWJKaExrSUpm/dWtTQWg1NHVVTmQ1/UnhoLmpwZWc",
    "https://imgs.search.brave.com/7u3ypuwT3STnlqfpKIpms2CEEoHCUuqkrrimobNwAB8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA2LzExLzQzLzQx/LzM2MF9GXzYxMTQz/NDE3OV9DSktIcVN2/N2hxN1BubmlMOEhq/U3NPSFRmcTJjd0Za/Mi5qcGc",
    "https://imgs.search.brave.com/a9ClSk44d-heklqN3whR2IHX22abbdr9SxMmUZVkeLg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9taXJv/Lm1lZGl1bS5jb20v/djIvMSpyajc5Zl9k/U3JEMEE1RU5ra1FB/eEpRLnBuZw",
  ];

  List Trending_Tech = [
    "https://imgs.search.brave.com/CMcZ4hrz4OQdS0SZEZqezNf735xImNGrU9CmX04G28o/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/Y20tYWxsaWFuY2Uu/Y29tL2h1YmZzLzE3/MjY1NjQzNF9tX25v/cm1hbF9ub25lJTIw/KDEpLmpwZw",
    "https://imgs.search.brave.com/EQZCo09pPu1gxnSiH4KX_8p4-o_mzxqNCZUnQqvb2-E/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9haS1yb2JvdC11/c2luZy1jeWJlci1z/ZWN1cml0eS1wcm90/ZWN0LWluZm9ybWF0/aW9uLXByaXZhY3lf/MzE5NjUtOTYyOC5q/cGc_c2l6ZT02MjYm/ZXh0PWpwZw",
    "https://imgs.search.brave.com/I94NDSXkeFrqYYjr9A5ZdcBqksdpLvwkXsK60bq8UOE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA1LzY4LzE2LzAz/LzM2MF9GXzU2ODE2/MDM1M19ReWRNOU5C/Z2I5TkdPVXp4emZ6/UzZwenVvbkZzOGlz/eC5qcGc",
  ];

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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Popular on Internet",
                      style: GoogleFonts.aboreto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: tealLevel3),
                    ),
                  ),
                ),
                SizedBox(
                    height: 230,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Content(
                                        Title: "Ai", accessValue: 2),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                Images[0],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Content(
                                        Title: "Privacy", accessValue: 3),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                Images[1],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Content(
                                        Title: "Ai Tools", accessValue: 4),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                Images[2],
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Trending Technology",
                      style: GoogleFonts.aboreto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: tealLevel3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Content(
                                Title: "Cybersecurity", accessValue: 0),
                          ));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Image.network(Trending_Tech[1]),
                          Positioned(
                            bottom: 25,
                            left: 10,
                            child: Text(
                              "Cyber Secutiry",
                              style: GoogleFonts.aboreto(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 15,
                            child: Text(
                              "View More",
                              style: GoogleFonts.aboreto(
                                fontSize: 12,
                                color: tealLevel3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Content(
                                Title: "Machine Learning", accessValue: 1),
                          ));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Image.network(
                            Trending_Tech[0],
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 25,
                            left: 10,
                            child: Text(
                              "Machine Learning",
                              style: GoogleFonts.aboreto(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 15,
                            child: Text(
                              "View More",
                              style: GoogleFonts.aboreto(
                                fontSize: 12,
                                color: tealLevel3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
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
