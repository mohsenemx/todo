// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/mainScreen.dart';
import 'package:todo/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskPopUp(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todo List App'),
      ),
      body: HomeScreen(),
    );
  }
}
