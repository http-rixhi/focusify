import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:focusify/views/screens/bottombar/analytics.dart';
import 'package:focusify/views/screens/sidebar/quizzes.dart';
import 'package:focusify/views/screens/sidebar/reminder_screen.dart';
import 'package:focusify/views/screens/sidebar/study_material.dart';
import 'package:toast/toast.dart';

import '../sidebar/Profile.dart';
import '../users/Signin.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    signOut() async {
      await auth.signOut();
    }


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 25, mainAxisSpacing: 25), children: [
          customGridBtn(title: 'Profile', icon: Icons.face, color: Colors.red, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));},),
          customGridBtn(title: 'Analytics', icon: Icons.auto_graph, color: Colors.blue, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsScreen()));},),
          customGridBtn(title: 'Quizzes', icon: CupertinoIcons.book, color: Colors.green, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));},),
          customGridBtn(title: 'Study Material', icon: Elusive.book, color: Colors.teal, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const StudyMaterialScreen()));},),
          customGridBtn(title: 'Reminders', icon: CupertinoIcons.alarm, color: Colors.deepPurple, onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ReminderScreen()));},),
          customGridBtn(title: 'Redeem', icon: FontAwesome5.coins, color: Colors.orange, onTap: () {},),
          customGridBtn(title: 'Logout', icon: Icons.logout, color: Colors.pink, onTap: () {
            signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
            Toast.show('Logged Out Successfully');
          },),
        ],),
      ),
    );
  }

  customGridBtn({required String title, required IconData icon, required Color color, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 5,
              offset: const Offset(0.2, 0.2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 88,),
            Text(title, style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
