import 'package:flutter/material.dart';
import 'package:myapp/screens/grocery_list_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59)
        )
      ),
      home: GroceryListScreen(),
    ),
  );
}
