import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<TaskModel> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: taskList
          .map((task) => Card(
                child: ExpansionTile(
                  title: TaskTile(task: task),
                  children: [
                    ListTile(
                      title: SelectableText.rich(TextSpan(children: [
                        const TextSpan(
                          text: 'Title\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: task.title,
                        ),
                        const TextSpan(
                          text: '\nDescription\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: task.description),
                      ])),
                    ),
                  ],
                ),
              ))
          .toList(),
    )));
  }
}
