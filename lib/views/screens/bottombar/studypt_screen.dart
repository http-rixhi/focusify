import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:focusify/views/widgets/chatmessage.dart';
import 'package:focusify/views/widgets/threedots.dart';
import 'package:velocity_x/velocity_x.dart';


class StudyPtScreen extends StatefulWidget {
  const StudyPtScreen({super.key});

  @override
  State<StudyPtScreen> createState() => _StudyPtScreenState();
}

class _StudyPtScreenState extends State<StudyPtScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late OpenAI? chatGPT;
  bool _isImageSearch = false;

  bool _isTyping = false;

  StreamSubscription? _subscription;

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
        // token: dotenv.env["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"],
        token: "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",
        // baseOption: HttpSetup(receiveTimeout: 6000);
      baseOption: HttpSetup(receiveTimeout: Duration(seconds: 10))
    );
    super.initState();
  }

  @override
  void dispose() {
    // chatGPT?.close();
    // chatGPT?.genImgClose();
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    if (_isImageSearch) {
      final request = GenerateImage(message.text, 1);

      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      final request =
      CompleteText(prompt: message.text, model: DavinciModel());

      final response = await chatGPT!.onCompletion(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text, isImage: false);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
                hintText: "Question/description"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _isImageSearch = false;
                _sendMessage();
              },
            ),
            // TextButton(
            //     onPressed: () {
            //       _isImageSearch = true;
            //       _sendMessage();
            //     },
            //     child: const Text("Generate"), style: ButtonStyle(
            //   textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 12))
            // ),)
          ],
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  )),
              if (_isTyping) const ThreeDots(),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}