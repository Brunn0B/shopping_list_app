import 'package:flutter/material.dart';
import 'package:shopping_list_app/views/shopping_list_screen.dart';
import 'package:shopping_list_app/services/local_data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalDataService dataService = LocalDataService();

    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShoppingListScreen(dataService: dataService),
    );
  }
}


