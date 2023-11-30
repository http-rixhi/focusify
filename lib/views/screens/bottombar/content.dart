
import 'package:flutter/material.dart';
import 'package:focusify/views/widgets/Colors.dart';
import 'package:focusify/views/widgets/data.dart';
import 'package:google_fonts/google_fonts.dart';

class Content extends StatefulWidget {
  const Content({super.key, required this.Title, required this.accessValue});

  final String Title;
  final int accessValue;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String Data = " ";
  String render() {
    if (widget.accessValue == 0) {
      Data = Cyber;
      return Data;
    } else if (widget.accessValue == 1) {
      Data = Machine;
      return Data;
    } else if (widget.accessValue == 2) {
      Data = Ai;
      return Data;
    } else if (widget.accessValue == 3) {
      Data = privacy;
      return Data;
    } else if (widget.accessValue == 4) {
      Data = Aitools;
      return Data;
    } else {
      return "Not Found";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    render();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                widget.Title,
                style: GoogleFonts.aboreto(fontSize: 40, color: tealColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                Data,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
