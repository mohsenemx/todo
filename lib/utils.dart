// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, dead_code, avoid_print

import 'package:flutter/material.dart';
import 'package:todo/mainScreen.dart';

const emptyNameSnackBar = SnackBar(
  content: Text('Task name cannot be empty'),
  duration: Duration(seconds: 2),
  backgroundColor: Colors.red,
);
const tooLongNameSnackBar = SnackBar(
  content:
      Text('Task name is too long! It shouldn\'t be longer than 40 characters'),
  duration: Duration(seconds: 2),
  backgroundColor: Colors.red,
);
TextEditingController taskName1 = TextEditingController();
bool isTaskDone = false;
void showAddTaskPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.yellow[300],
        scrollable: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Center(child: Text('Add a new task')),
        content: Container(
          height: 210,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextField(
                    controller: taskName1,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter a task name',
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TaskDone(),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (taskName1.text.trim() == '') {
                      // handle if task name is empty
                      ScaffoldMessenger.of(context)
                          .showSnackBar(emptyNameSnackBar);
                    } else if (taskName1.text.length >= 40) {
                      // handle if task name is too long
                      ScaffoldMessenger.of(context)
                          .showSnackBar(tooLongNameSnackBar);
                    } else {
                      // Nothing is empty, create the task

                      newTaskisAdded();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add task'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class TaskDone extends StatefulWidget {
  const TaskDone({super.key});

  @override
  State<TaskDone> createState() => _TaskDoneState();
}

class _TaskDoneState extends State<TaskDone> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTaskDone = !isTaskDone;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: isTaskDone,
            onChanged: (value) {
              setState(() {
                isTaskDone = value ?? false;
              });
            },
            fillColor:
                MaterialStateColor.resolveWith((states) => Colors.yellow[800]!),
          ),
          SizedBox(
            width: 2,
          ),
          Text('Done?'),
        ],
      ),
    );
  }
}

void newTaskisAdded() {
  var wtf = [taskName1.text, isTaskDone];
  toDoList.add(wtf);

  taskName1.text = '';
  isTaskDone = false;
  // where I should call realUpdateUI()
  setStorage();
}
