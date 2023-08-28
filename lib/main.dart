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
      theme: ThemeData(
        primaryColor: Colors.yellow[800],
        splashColor: Colors.yellow[600],
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.yellow[800],
          focusColor: Colors.yellow,
        ),
      ),
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
      backgroundColor: Colors.yellow[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[800],
        onPressed: () {
          showAddTaskPopUp(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Todo List App'),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
