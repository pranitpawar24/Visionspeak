import 'package:flutter/material.dart';
import 'capture_screen.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaptureScreen(),
                  ),
                );
              },
              child: const Text('Capture Image'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Pick from Gallery'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: null, // disabled for now
              child: const Text('Speak Text'),
            ),
          ],
        ),
      ),
    );
  }
}
