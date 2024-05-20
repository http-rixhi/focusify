import 'package:flutter/material.dart';

import '../../widgets/Colors.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkLevel1,
        title: Text('Quizzes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Data Structure', style: TextStyle(fontSize: 22),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Maths', style: TextStyle(fontSize: 22),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Cyber Security', style: TextStyle(fontSize: 22),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) => AlertDialog(title: Text('No quizzes available'),));
              },
              child: Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Operating System', style: TextStyle(fontSize: 22),),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Python', style: TextStyle(fontSize: 22),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Object Oriented Programming', style: TextStyle(fontSize: 22),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
