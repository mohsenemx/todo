// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

void showAddTaskPopUp(BuildContext context) {
  TextEditingController taskName = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Center(child: Text('Add a new task')),
        content: Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
                    controller: taskName,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter a task name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 5,
                      ),
                      icon: Icon(
                        Icons.text_fields,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
                    controller: taskName,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter a task description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 5,
                      ),
                      icon: Icon(
                        Icons.text_fields,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
