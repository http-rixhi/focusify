// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswal

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class studyAI extends StatefulWidget {
  const studyAI({super.key});

  @override
  State<studyAI> createState() => _studyAIState();
}

class _studyAIState extends State<studyAI> {
  TextEditingController message = TextEditingController();
  var _data;

  final model =
  FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash');

  @override
  Widget build(BuildContext context) {
    String markdownText = _data.toString();
    markdownToPlainText(markdownText);
    _data ??= "🤖 Heyyy, I'm FocusAI your doubt assistant. Ask me your doubts...";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: textToSpeech, icon: const Icon(FontAwesome5.play, size: 15,)),
              IconButton(onPressed: () {
                FlutterTts().pause();
              }, icon: const Icon(FontAwesome5.pause, size: 15,)),
              IconButton(onPressed: () {
                FlutterTts().stop();
              }, icon: const Icon(FontAwesome5.stop, size: 15,)),
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white38),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: GptMarkdown(_data),
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(FontAwesome5.robot),
            title: TextField(
              controller: message,
              decoration: const InputDecoration(
                  hintText: "Ask your Doubts...",
                  ),
            ),
            trailing: IconButton(onPressed: () {
              setState(() {
                _data = "Searching for your query, please wait...";
              });
              textToSpeech();
              getResults();
            }, icon: const Icon(Icons.send)),
          ),
        ],
      ),
    );
  }

  void getResults() async {
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

  // Text to Speech(tts) function for speaking the ai response
  textToSpeech() async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.9);
    await flutterTts.setSpeechRate(0.7);
    await flutterTts.speak(_data.toString());
  }
}
