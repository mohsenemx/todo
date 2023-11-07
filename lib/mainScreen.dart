// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable, unused_element, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';
// Global variables

List toDoList = [
  ['Try clicking on + icon in buttom of screen', true],
];
void setStorage() {
  box.put('storage', toDoList);
}

void loadStorage() {
  if (box.get('storage') == null) {
    todo();
  } else {
    toDoList = box.get('storage');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>>? _animations; // List of animations
  void realUpdateUI() {
    setState(() {
      toDoList = box.get('storage') ?? toDoList;
    });
  }

  void todoItemStateisChanged(bool value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
    realUpdateUI();
  }

  void removeItem(index) {
    setState(() {
      toDoList.removeAt(index);
    });
    realUpdateUI();
    restartAnimation();
  }

  void updateN() {
    _animations = List.generate(
      toDoList.length,
      (index) {
        return Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / toDoList.length, // Stagger each item
            1.0,
            curve: Curves.easeInOut,
          ),
        ));
      },
    );
    _controller.forward();
  }

  void restartAnimation() {
    _controller.reset(); // Reset the animation controller
    updateN(); // Trigger the animation again
  }

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    Timer.periodic(Duration(milliseconds: 300), (Timer t) => realUpdateUI());
  }

  @override
  Widget build(BuildContext context) {
    loadStorage();
    updateN();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return SlideTransition(
              position: _animations![index],
              child: TaskItem(
                taskName: toDoList[index][0],
                isTaskDone: toDoList[index][1],
                onChanged: (value) => todoItemStateisChanged(value!, index),
                onTap: () => removeItem(index),
              ),
            );
          },
        );
      },
    );
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
                  Wrap(
                    children: [
                      Text(taskName),
                    ],
                  ),
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
