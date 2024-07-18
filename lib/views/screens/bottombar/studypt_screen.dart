// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:markdown/markdown.dart' as md;

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
    String markdownText = _data.toString();
    String plainText = markdownToPlainText(markdownText);
    if(_data == null) {
      _data = "Heyyy, I'm your doubt assistant. Ask me anything...\n"
          """
                 _______
               _/       \\_
              / |       | \\
             /  |__   __|  \\
           |__/((o| |o))\\__|
            |      | |      |
            |\\     |_|     /|
            | \\           / |
             \\| /   _   \\ |/
              \\ | \\___/ | /
               \\_________/
               _|_____|_
           ____|_________|____
          /                   \\ 
          """;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: 500,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8
                      ),
                      child: Markdown(data: _data)
                    ),
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

  String markdownToPlainText(String markdown) {
    final document = md.Document();
    final parsed = document.parseInline(markdown);
    return parsed.map((e) => e.textContent).join();
  }
}
