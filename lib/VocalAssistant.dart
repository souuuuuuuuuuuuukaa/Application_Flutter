/*
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class VocalAssistant extends StatefulWidget {
  const VocalAssistant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VocalAssistantState createState() => _VocalAssistantState();
}

class _VocalAssistantState extends State<VocalAssistant> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String? _response;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    await _generateResponse();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> _generateResponse() async {
    if (_lastWords.isEmpty) return; // Si aucun mot n'a été détecté

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyAXlDRHVNUGfzspUhegbOELU_cVu7wRlfc', // Remplacez par votre clé API
    );

    try {
      final response = await model.generateContent([Content.text(_lastWords)]);
      setState(() {
        _response = response.text; // Réponse générée par l'API
      });
    } catch (e) {
      setState(() {
        _response = 'Error: Unable to generate a response.';
      });
      print('Error generating content: $e');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Vocal Assistant'),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.mic,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _speechEnabled
                        ? 'Listening: $_lastWords'
                        : 'Speech Recognition is not available.',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _speechToText.isListening
                      ? _stopListening
                      : _startListening,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    _speechToText.isListening ? Icons.stop : Icons.mic,
                    color: const Color.fromARGB(255, 167, 97, 97),
                  ),
                ),
              ],
            ),
          ),
          if (_response != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Response:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _response!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
}*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // Pour kIsWeb

class VocalAssistant extends StatefulWidget {
  const VocalAssistant({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VocalAssistantState createState() => _VocalAssistantState();
}

class _VocalAssistantState extends State<VocalAssistant> {
  //final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  final ImagePicker _imagePicker = ImagePicker();

  bool _speechEnabled = false;
  String _lastWords = '';
  String? _response;
  XFile? _selectedImage; // Utilisation de XFile pour la compatibilité Web

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    }
  }

  void _stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
      await _generateResponse();
      setState(() {});
    }
  }

  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> _generateResponse() async {
    if (_lastWords.isEmpty) return;

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyAXlDRHVNUGfzspUhegbOELU_cVu7wRlfc',
    );

    try {
      final response = await model.generateContent([Content.text(_lastWords)]);
      setState(() {
        _response = response.text;
      });
      if (_response != null) {
      }
    } catch (e) {
      setState(() {
        _response = 'Error: Unable to generate a response.';
      });
      if (kDebugMode) {
        print('Error generating content: $e');
      }
    }
  }



  Future<void> _pickImage() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image; // XFile pour compatibilité Web
        });
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick an image.')),
      );
    }
  }

  Widget _buildImagePreview() {
    if (_selectedImage == null) return const SizedBox.shrink();

    if (kIsWeb) {
      return Image.network(
        _selectedImage!.path,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(_selectedImage!.path),
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocal Assistant'),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
            tooltip: 'Upload Image',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Microphone Section
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mic,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _speechEnabled
                          ? 'Listening: $_lastWords'
                          : 'Speech Recognition is not available.',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Image Section
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Uploaded Image:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildImagePreview(),
                  ],
                ),
              ),

            // Buttons for Speech
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _speechToText.isListening
                    ? _stopListening
                    : _startListening,
                child: Icon(
                  _speechToText.isListening ? Icons.stop : Icons.mic,
                ),
              ),
            ),

            // Response Section
            if (_response != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Response:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _response!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}