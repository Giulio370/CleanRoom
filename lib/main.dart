import 'package:dinamico_hotel_columbia/screens/rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa per gestire il full-screen
import 'screens/setup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Assicura che i binding siano inizializzati

  // Imposta l'app in modalità full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RoomsScreen(), // Imposta la schermata iniziale
    );
  }
}
