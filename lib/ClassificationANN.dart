import 'package:flutter/material.dart';

class ClassificationANN extends StatelessWidget {
  const ClassificationANN({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification (ANN)'),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Image Classification using ANN!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This section demonstrates image classification using Artificial Neural Networks (ANN). Here, you can explore techniques to train an ANN for classifying images into various categories.',
              style: TextStyle(fontSize: 16),
            ),
            // You can add more content, like images, buttons, etc.
          ],
        ),
      ),
    );
  }
}





/*import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class ClassificationANN extends StatefulWidget {
  const ClassificationANN({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClassificationANNState createState() => _ClassificationANNState();
}



class _ClassificationANNState extends State<ClassificationANN> {
  File? _image;
  String _result = "";
  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load the pre-trained model
  loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/Bestmodel.tflite", // Make sure the model is in the assets directory
        labels: "assets/labels.txt", // If you have label file
      );
      print(res);
    } on PlatformException {
      print("Failed to load model.");
    }
  }

  // Function to pick image from gallery or camera
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = "";
        _confidence = 0.0;
      });
      classifyImage(_image!);
    }
  }

  // Function to preprocess and classify image
  classifyImage(File image) async {
    try {
      var result = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,  // Adjust for your model's input
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      if (result != null && result.isNotEmpty) {
        setState(() {
          _result = result[0]["label"];
          _confidence = result[0]["confidence"];
        });
      }
    } on PlatformException {
      print("Failed to run model.");
    }
  }

  // Dispose model when done
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fashion MNIST Classifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text("Aucune image sélectionnée")
                : Image.file(
                    _image!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: const Text("Choisir une image"),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty) ...[
              const Text("Résultat de la prédiction:"),
              Text("Classe: $_result", style: const TextStyle(fontSize: 18)),
              Text("Confiance: ${(_confidence * 100).toStringAsFixed(2)}%", style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
*/