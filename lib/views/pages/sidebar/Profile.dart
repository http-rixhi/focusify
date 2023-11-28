// // ignore_for_file: camel_case_types, non_constant_identifier_names

// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// class profile_view extends StatelessWidget {
//   const profile_view({super.key});

//   Widget profile_option(String optionName, iconName) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
//       child: InkWell(
//         // ignore: avoid_print
//         onTap: () => print("Hi"),
//         child: SizedBox(
//           height: 50,
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(
//                 iconName,
//                 size: 30,
//                 color: const Color(0xff4fd6d9),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(optionName,
//                   style:
//                       const TextStyle(color: Color(0xff70808d), fontSize: 20)),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_rounded,
//                 size: 30,
//                 color: Color(0xffffffff),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Color(0xff53585b), Color(0xff22272a)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter)),
//         child: SafeArea(
//           child: Scaffold(
//             // backgroundColor: Color(0xff53585b),
//             backgroundColor: Colors.transparent,
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: const Color(0xff4fd6d9)),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(100))),
//                     child: const CircleAvatar(
//                       backgroundImage: AssetImage('assets/photo.jpg'),
//                       radius: 70,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   InkWell(
//                     child: Text(
//                       "Pushpendra Baswal",
//                       style: GoogleFonts.aBeeZee(
//                           fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "App Developer",
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 20,
//                         letterSpacing: -2,
//                         color: const Color(0xff70808d)),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(24.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               "Joined:",
//                               style: TextStyle(
//                                   color: Color(0xff4fd6d9), fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Mar 18th, 2014",
//                               style: TextStyle(color: Color(0xff70808d)),
//                             )
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "Ranking Score:",
//                               style: TextStyle(
//                                   color: Color(0xff4fd6d9), fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text("1211",
//                                 style: TextStyle(color: Color(0xff70808d)))
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "Rarity",
//                               style: TextStyle(
//                                   color: Color(0xff4fd6d9), fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text("Shadow Series",
//                                 style: TextStyle(color: Color(0xff70808d)))
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Column(
//                     children: [
//                       profile_option("Personal information", Icons.home),
//                       profile_option("Game Progress", Icons.pie_chart),
//                       profile_option("Billing Methods", Icons.payment),
//                       profile_option("Settings", Icons.settings),
//                       profile_option("Logout", Icons.logout)
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
