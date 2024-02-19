import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/services/guid_gen.dart';

class AddTasksWidget extends StatelessWidget {
  AddTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add Task',
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
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                  focusColor: Color.fromARGB(255, 44, 151, 209),
                ),
              ),
            ),
            TextField(
              autofocus: true,
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(),
                focusColor: Color.fromARGB(255, 44, 151, 209),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('cancel')),
              ElevatedButton(
                onPressed: () {
                  var task = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: GUIDGen.generate(),
                    date: '',
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
                  print(task);
                  print(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: Text('Add'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
