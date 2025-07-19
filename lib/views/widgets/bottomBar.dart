import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:focusify/views/screens/bottombar/others_screen.dart';
import 'package:focusify/views/screens/sidebar/quizzes.dart';
import 'package:focusify/views/screens/sidebar/study_material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    studyAI(),
    OthersScreen()
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
        child: Container(
          color: Colors.transparent,
          transform: Matrix4.translationValues(10, -1, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: darkLevel5,
            ),
            child: GNav(
                gap: 10,
                activeColor: Colors.white,
                tabBackgroundColor: darkLevel5,
                haptic: true,
                tabBorderRadius: 30,
                iconSize: 21,
                curve: Curves.easeInOut,
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
                    text: "FocusAI",
                  ),
                  GButton(
                    icon: Icons.person,
                    iconColor: tealColor,
                    text: "Others",
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      appBar: AppBar(
        toolbarHeight: 58,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FOCUSIFY",
              style: GoogleFonts.leagueSpartan(fontSize: 35, color: Colors.blueAccent),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Distraction-free educational app",
                style: GoogleFonts.abhayaLibre(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(FontAwesome5.coins, color: Colors.yellow,)),
              const Text('0', style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
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
                  child: Text('Quizzes'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Study Material'),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: Text('Redeem'),
                ),
                const PopupMenuItem(
                  value: 5,
                  child: Text('Reminders'),
                ),
                const PopupMenuItem(
                  value: 6,
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
              }
              if (value == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsScreen()));
              }
              if (value == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              }
              if (value == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StudyMaterialScreen()),
                );
              }
              if (value == 5) {
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
