import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPdf extends StatefulWidget {
  const UploadPdf({super.key});

  @override
  State<UploadPdf> createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  late File _pdfFile;

  Future<void> _pickPdf() async {
    final pdfFile = await ImagePicker().pickMedia(
      imageQuality: 100,
    );
    if (pdfFile != null) {
      setState(() {
        _pdfFile = File(pdfFile.path);
      });
    }
  }

  Future<void> _uploadPdf() async {
    if (_pdfFile == null) {
      return;
    }

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final destination= 'pdfs/$fileName';

    final ref = FirebaseStorage.instance.ref(destination);
    final uploadTask = ref.putFile(_pdfFile);

    uploadTask.snapshotEvents.listen((event) {
      // Track upload progress
    });

    await uploadTask.whenComplete(() async {
      final url = await ref.getDownloadURL();

      // Save the PDF URL to Firebase Realtime Database or Firestore
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickPdf,
              child: const Text('Pick PDF'),
            ),
            ElevatedButton(
              onPressed: _uploadPdf,
              child: const Text('Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
