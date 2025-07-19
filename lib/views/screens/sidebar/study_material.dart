import 'package:focusify/views/widgets/upload_file.dart';
import 'package:flutter/material.dart';

import '../../widgets/Colors.dart';

class StudyMaterialScreen extends StatefulWidget {
  const StudyMaterialScreen({super.key});

  @override
  State<StudyMaterialScreen> createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends State<StudyMaterialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadPdf()));
      }, child: Icon(Icons.add),),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkLevel1,
        title: Text('Study Material'),
      ),
      body: Column(
        children: [

        ],
      )
    );
  }

  addFilesButton() {
  }
}
