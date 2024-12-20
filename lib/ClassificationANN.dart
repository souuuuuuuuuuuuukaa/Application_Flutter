/*import 'package:flutter/material.dart';

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
}*/


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ClassificationANN extends StatefulWidget {
  const ClassificationANN({super.key});

  @override
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

  loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/Models/ANN_model.tflite", // Mettre à jour le chemin
       // labels: "assets/Models/labels.txt", // Mettre à jour le chemin
      );
      print("Modèle chargé : $res");
    } catch (e) {
      print("Erreur lors du chargement du modèle : $e");
    }
  }

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

  classifyImage(File image) async {
    try {
      var result = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 3,
        threshold: 0.1,
        asynch: true,
      );

      if (result != null && result.isNotEmpty) {
        setState(() {
          _result = result[0]["label"];
          _confidence = result[0]["confidence"];
        });
        print("Prédiction : $_result avec une confiance de ${_confidence * 100}%");
      } else {
        setState(() {
          _result = "Aucun résultat trouvé.";
          _confidence = 0.0;
        });
      }
    } catch (e) {
      print("Erreur lors de l'exécution du modèle : $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ANN Image Classifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text("Aucune image sélectionnée")
                : kIsWeb
                    ? Image.network(
                        _image!.path,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
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
              const Text("Résultat de la prédiction :"),
              Text("Classe : $_result", style: const TextStyle(fontSize: 18)),
              Text("Confiance : ${(_confidence * 100).toStringAsFixed(2)}%", style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
