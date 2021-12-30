import 'package:flutter/material.dart';
import 'package:todoey/widgets/task_tile.dart';
import 'package:todoey/models/task_data.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return TaskTile(
                taskTitle: task.name,
                isChecked: task.isDone,
                checkboxCallback: (bool? checkboxState) {
                  taskData.updateTask(task);
                },
                longPressCallback: () {
                  Alert(
                    context: context,
                    type: AlertType.none,
                    title: "Want to delete?",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.lightBlueAccent,
                      ),
                      DialogButton(
                        child: Text(
                          "DELETE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          taskData.deleteTask(task);
                          Navigator.pop(context);
                        },
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(99, 201, 254, 1.0),
                          Color.fromRGBO(101, 199, 247, 1.0),
                          Color.fromRGBO(0, 82, 212, 1.0)
                        ]),
                      )
                    ],
                  ).show();
                },
              );
            });
      },
    );
  }
}
