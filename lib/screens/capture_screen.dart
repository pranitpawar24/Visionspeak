import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../services/gemini_service.dart';
class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  File? _image;
  String _recognizedText = '';
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer =
  TextRecognizer(script: TextRecognitionScript.latin);
  final FlutterTts _flutterTts = FlutterTts();

  // ---------------- IMAGE PICK ----------------

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);

    if (picked != null) {
      final File imageFile = File(picked.path);

      setState(() {
        _image = imageFile;
        _recognizedText = '';
        _isProcessing = true;
      });

      await _processImage(imageFile);
    }
  }

  // ---------------- OCR PROCESS ----------------
  Future<void> _processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);

    final recognizedText =
    await _textRecognizer.processImage(inputImage);

    if (recognizedText.text.isNotEmpty) {
      setState(() {
        _recognizedText = recognizedText.text;
        _isProcessing = false;
      });

      await _speakText();
    } else {
      final description =
      await GeminiService.describeImage(imageFile);

      setState(() {
        _recognizedText = description;
        _isProcessing = false;
      });

      await _flutterTts.stop();
      await _flutterTts.speak(description);
    }
  }

  // ---------------- TEXT TO SPEECH ----------------

  Future<void> _speakText() async {
    if (_recognizedText.isNotEmpty &&
        _recognizedText != "No text found in the image.") {
      await _flutterTts.stop();
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.speak(_recognizedText);
    }
  }

  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
  }

  // ---------------- DISPOSE ----------------

  @override
  void dispose() {
    _textRecognizer.close();
    _flutterTts.stop();
    super.dispose();
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VisionSpeak OCR"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_image!),
            )
                : const Text("No image selected"),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            if (_isProcessing) const CircularProgressIndicator(),

            const SizedBox(height: 20),

            const Text(
              "Recognized Text:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _recognizedText.isEmpty
                    ? "No text extracted yet."
                    : _recognizedText,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _speakText,
                  icon: const Icon(Icons.volume_up),
                  label: const Text("Speak"),
                ),
                ElevatedButton.icon(
                  onPressed: _stopSpeaking,
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}