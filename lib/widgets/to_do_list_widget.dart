import 'package:flutter/material.dart';
import 'package:practice_bloc_n_cubit_v6/models/to_do.dart';

class ToDoListWidget extends StatelessWidget {
  final List<ToDo> tasks;

  const ToDoListWidget({Key key, @required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.id),
            trailing: Checkbox(
              onChanged: null,
              value: task.isFinished,
            ),
          );
        });
  }
}
