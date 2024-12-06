
import 'package:flutter/material.dart';

class ClassificationCNN extends StatelessWidget {
  const ClassificationCNN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification (CNN)'),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Image Classification using CNN!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This section demonstrates image classification using (CNN). Here, you can explore techniques to train an CNN for classifying images into various categories.',
              style: TextStyle(fontSize: 16),
            ),
            // You can add more content, like images, buttons, etc.
          ],
        ),
      ),
    );
  }
}
