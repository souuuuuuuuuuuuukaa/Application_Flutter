/*import 'package:application_firebase1/ClassificationANN.dart';
import 'package:application_firebase1/ClassificationCNN.dart';
import 'package:flutter/material.dart';

class DrawrApp extends StatelessWidget {
  const DrawrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header section
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 158, 121), // Custom theme color
                  Colors.white,
                ],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/profile.png'), // Replace with your image
                ),
                SizedBox(width: 16),
                Text(
                  'Welcome, User!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu section
          ExpansionTile(
            title: const Text(
              'AI & Machine Learning',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.memory, color: Color.fromARGB(255, 54, 33, 243)),
            children: [
              ListTile(
                title: const Text('Image Classification (ANN)'),
                leading: const Icon(Icons.device_hub, color: Colors.orange),
                onTap: () {
                  // Navigate to Image Classification (ANN) page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClassificationANN(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Image Classification (CNN)'),
                leading: const Icon(Icons.image, color: Colors.green),
                onTap: () {
                  // Add navigation logic here
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClassificationCNN(),
                       ),
                    );
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Stock Price Prediction'),
            leading: const Icon(Icons.trending_up, color: Colors.red),
            onTap: () {
              // Add navigation logic here
            },
          ),
          ListTile(
            title: const Text('Vocal Assistant (LLM)'),
            leading: const Icon(Icons.mic, color: Colors.purple),
            onTap: () {
              // Add navigation logic here
            },
          ),
          ListTile(
            title: const Text('RAG (Retrieval-Augmented Generation)'),
            leading: const Icon(Icons.library_books, color: Colors.indigo),
            onTap: () {
              // Add navigation logic here
            },
          ),
          
          const Divider(), // Add a divider for better visual separation
          
          // Footer section
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings, color: Colors.grey),
            onTap: () {
              // Navigate to Settings
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, color: Colors.grey),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}
*/
import 'package:application_firebase1/VocalAssistant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:application_firebase1/ClassificationANN.dart';
import 'package:application_firebase1/ClassificationCNN.dart';

class DrawrApp extends StatefulWidget {
  const DrawrApp({super.key});

  @override
  State<DrawrApp> createState() => _DrawrAppState();
}

class _DrawrAppState extends State<DrawrApp> {
  String firstName = "";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    getUserInfo(); // Récupérer les données utilisateur dès que le widget est chargé
  }

  Future<void> getUserInfo() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userDoc.exists) {
          setState(() {
            firstName = userDoc['firstName'] ?? ""; // Assurez-vous que les champs existent
            lastName = userDoc['lastName'] ?? "";
          });
        }
      }
    } catch (e) {
      print('Error retrieving user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header section
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 158, 121), // Couleur personnalisée
                  Colors.white,
                ],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: const Color.fromARGB(255, 37, 99, 70),
                  child: Text(
                    firstName.isNotEmpty && lastName.isNotEmpty
                        ? '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}'
                        : '?', // Affiche '?' si les données ne sont pas encore chargées
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                child: Text(
                firstName.isNotEmpty && lastName.isNotEmpty
                ? '$firstName $lastName!'
                : 'Welcome, User!',
                style: const TextStyle(
                fontSize: 18,
               fontWeight: FontWeight.bold,
                 color: Colors.black,
                 ),
                overflow: TextOverflow.ellipsis, // Ajoute des "..." si le texte est trop long
                    ),
                   ),
              ],
            ),
          ),
          
          // Menu section
          ExpansionTile(
            title: const Text(
              'AI & Machine Learning',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.memory, color: Color.fromARGB(255, 54, 33, 243)),
            children: [
              ListTile(
                title: const Text('Image Classification (ANN)'),
                leading: const Icon(Icons.device_hub, color: Colors.orange),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClassificationANN(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Image Classification (CNN)'),
                leading: const Icon(Icons.image, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClassificationCNN(),
                    ),
                  );
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Stock Price Prediction'),
            leading: const Icon(Icons.trending_up, color: Colors.red),
            onTap: () {
              // Ajouter la logique de navigation ici
            },
          ),
          ListTile(
            title: const Text('Vocal Assistant (LLM)'),
            leading: const Icon(Icons.mic, color: Colors.purple),
            onTap: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VocalAssistant(),
                    ),
                  );
            },
          ),
          ListTile(
            title: const Text('RAG (Retrieval-Augmented Generation)'),
            leading: const Icon(Icons.library_books, color: Colors.indigo),
            onTap: () {
              // Ajouter la logique de navigation ici
            },
          ),
          
          const Divider(), // Séparateur pour une meilleure visibilité
          
          // Footer section
          /*ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings, color: Colors.grey),
            onTap: () {
              // Ajouter la logique de navigation ici
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, color: Colors.grey),
            onTap: () {
              // Ajouter la logique de déconnexion ici
            },
          ),*/
        ],
      ),
    );
  }
}
