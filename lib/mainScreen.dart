// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable, unused_element, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'main.dart';
// Global variables

List toDoList = [
  ['Kidnap you', true],
  ['Kill your mom', true],
  ['Kill your father', false],
  ['Prove mammd that I\'m an idiot'],
];
void setStorage() {
  box.put('storage', toDoList);
}

void loadStorage() {
  if (box.get('storage') == null) {
  } else {
    toDoList = box.get('storage');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void realUpdateUI() {
    setState(() {
      toDoList = box.get('storage') ?? toDoList;
    });
  }

  void todoItemStateisChanged(bool value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void removeItem(index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadStorage();

    return Container(
        child: ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return TaskItem(
          taskName: toDoList[index][0],
          isTaskDone: toDoList[index][1],
          onChanged: (value) => todoItemStateisChanged(value!, index),
          onTap: () => removeItem(index),
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
  void Function()? onTap;
  TaskItem({
    super.key,
    required this.isTaskDone,
    required this.taskName,
    required this.onChanged,
    required this.onTap,
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
            Center(
              child: Row(
                children: [
                  Checkbox(
                    value: isTaskDone,
                    onChanged: onChanged,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Colors.yellow[800]!),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(taskName),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: onTap,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
