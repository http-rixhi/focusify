// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:velocity_x/velocity_x.dart';

class studyAI extends StatefulWidget {
  const studyAI({super.key});

  @override
  State<studyAI> createState() => _studyAIState();
}

class _studyAIState extends State<studyAI> {
  TextEditingController message = TextEditingController();
  var _data;

  var model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyBSwSQ0NQ_bNiP9LlsKqyES6YATYaEBtdA',
  );



  @override
  Widget build(BuildContext context) {

    if(_data == null) {
      _data = "Heyyy, I'm your doubt assistant. Ask me anything...";
    }

    // var markdown = """
    // SJDFKAJ sjnds *fdsfds* **sdfdsfsdf**
    // """;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8
                    ),
                    child: Text(_data.toString()),
                  ),
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(FontAwesome5.robot),
            title: TextField(
              controller: message,
              decoration: InputDecoration(
                  hintText: "Ask your Doubts...",
                  ),
            ),
            trailing: IconButton(onPressed: () {
              setState(() {
                _data = "Searching for your query...";

              });
              GetResults();
            }, icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }

  void GetResults() async {
    var prompt = message.text;
    var content = [Content.text(prompt)];
    var response = await model.generateContent(content);
    setState(() {
      _data = response.text;
    });
  }
}
