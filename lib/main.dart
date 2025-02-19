// main.dart

import 'package:flutter/material.dart';
import 'Pages/mainPage.dart'; // Importing the mainPage.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WasteGuardPage(), // Set WasteGuardPage as the home page
    );
  }
}
