// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

// Global variables

List toDoList = [
  ['Kidnap you', true],
  ['Kill your mom', true],
  ['Kill your father', false]
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void todoItemStateisChanged(bool value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return TaskItem(
          taskName: toDoList[index][0],
          isTaskDone: toDoList[index][1],
          onChanged: (value) => todoItemStateisChanged(value!, index),
        );
      },
    ));
  }
}

void todo() {}

class TaskItem extends StatelessWidget {
  final taskName;

  final isTaskDone;
  void Function(bool?)? onChanged;
  TaskItem({
    super.key,
    required this.isTaskDone,
    required this.taskName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isTaskDone,
                  onChanged: onChanged,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(taskName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
