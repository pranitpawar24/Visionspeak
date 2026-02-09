import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromCamera() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_image != null)
            Image.file(_image!, height: 250)
          else
            const Text('No image selected'),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: _pickFromCamera,
            child: const Text('Capture Image'),
          ),

          const SizedBox(height: 15),

          ElevatedButton(
            onPressed: _pickFromGallery,
            child: const Text('Pick from Gallery'),
          ),
        ],
      ),
    );
  }
}
