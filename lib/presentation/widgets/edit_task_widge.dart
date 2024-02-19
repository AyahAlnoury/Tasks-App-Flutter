import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';

class EditTasksWidget extends StatelessWidget {
  final TaskModel oldTask;
  EditTasksWidget({Key? key, required this.oldTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Edit Task',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                autofocus: true,
                controller: titleController,
                decoration: InputDecoration(
                    label: Text('Title'), border: OutlineInputBorder()),
              ),
            ),
            TextField(
              autofocus: true,
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                  label: Text('Description'), border: OutlineInputBorder()),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('cancel')),
              ElevatedButton(
                onPressed: () {
                  var editedTask = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: oldTask.id,
                    isDone: false,
                    isFavorite: oldTask.isFavorite,
                    date: DateTime.now().toString(),
                  );
                  context
                      .read<TasksBloc>()
                      .add(EditTask(oldTask: oldTask, newTask: editedTask));
                  Navigator.pop(context);
                },
                child: Text('Save'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
