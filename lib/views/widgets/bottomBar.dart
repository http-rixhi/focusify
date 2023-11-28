import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:focusify/views/screens/bottombar/home_screen.dart';
import 'package:focusify/views/screens/bottombar/homescreen.dart';
import 'package:focusify/views/screens/bottombar/studypt_screen.dart';
import 'package:focusify/views/screens/bottombar/youtube_screen.dart';
import 'package:focusify/views/screens/bottombar/Profile.dart';
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
    ProfileView(user: null,),
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
                      icon: Icons.search,
                      iconColor: tealColor,
                      text: "Youtube",
                    ),
                    GButton(
                      icon: Icons.data_object_outlined,
                      iconColor: tealColor,
                      text: "AI",
                    ),
                    GButton(
                      icon: Icons.person,
                      iconColor: tealColor,
                      text: "User",
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
      body: _widgetOptions.elementAt(_selectedIndex),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Focusify",
              style: GoogleFonts.aboreto(fontSize: 40, color: tealColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "A Way to New Learning...",
                style: GoogleFonts.abhayaLibre(fontSize: 14, color: tealLevel3),
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
                const PopupMenuItem(
                  value: 0,
                  child: Text('Profile'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Analysis'),
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
