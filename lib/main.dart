// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/mainScreen.dart';
import 'package:todo/utils.dart';
import 'aboutMeScreen.dart';

var box;
Future<void> initStorage() async {
  box = await Hive.openBox('todo_storage');
  // ar wtf = Hive.box('todo_storage');
  box.put('test', 'success');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await initStorage();

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
        primaryColorLight: Colors.yellow[800],
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
        title: Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Center(
            child: Text('Todo List App'),
          ),
        ),
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutMe()),
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: HomeScreen(),
      ),
    );
  }
}
