import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:focusify/views/screens/bottombar/analytics.dart';

import 'package:focusify/views/screens/bottombar/homescreen.dart';
import 'package:focusify/views/screens/bottombar/studypt_screen.dart';
import 'package:focusify/views/screens/bottombar/youtube_screen.dart';
import 'package:focusify/views/screens/sidebar/Profile.dart';
import 'package:focusify/views/screens/users/Signin.dart';
import 'package:focusify/views/widgets/Colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:toast/toast.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreenWiki(),
    YoutubeScreen(),
    StudyPtScreen(),
    AnalyticsScreen()
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Expanded(
          child: Container(
            color: Colors.transparent.withOpacity(0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35), color: darkLevel1),
                  child: GNav(
                      gap: 8,
                      activeColor: Colors.white,
                      tabBackgroundColor: darkLevel1,
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                          iconColor: tealColor,
                          text: "Home",
                        ),
                        GButton(
                          icon: Elusive.youtube,
                          iconColor: tealColor,
                          text: "FocusTube",
                        ),
                        GButton(
                          icon: Icons.data_object_outlined,
                          iconColor: tealColor,
                          text: "AI Bot",
                        ),
                        GButton(
                          icon: Icons.person,
                          iconColor: tealColor,
                          text: "Analytics",
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      })),
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FOCUSIFY",
              style: GoogleFonts.leagueSpartan(fontSize: 47, color: Colors.blueAccent),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 19),
              child: Text(
                "Distraction-free educational app",
                style: GoogleFonts.abhayaLibre(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: darkLevel1,
            icon: const Icon(
              Icons.more_vert,
              color: tealLevel3,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                  }, child: Text('Profile')),
                ),
                PopupMenuItem(
                  value: 1,
                  child: TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnalyticsScreen()));
                  }, child: Text('Analysis')),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Chatbot'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Settings'),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 4) {
                signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
                Toast.show('Logged Out Successfully');
              }
              // if (value == 0) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const ProfileView(),
              //     ),
              //   );
              // }
            },
          )
        ],
      ),
    );
  }
}
