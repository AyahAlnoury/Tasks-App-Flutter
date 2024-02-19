import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/presentation/widgets/edit_task_widge.dart';
import 'package:tasks_app/presentation/widgets/popup_menu_widget.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    super.key,
    required this.task,
  });

  final TaskModel task;
  void _removeOrDeleteTask(BuildContext context, TaskModel task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 44, 151, 209),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: task.isDeleted == false
                  ? (value) {
                      context.read<TasksBloc>().add(UpdateTask(task: task));
                    }
                  : null,
            ),
            PopupMenu(
              task: task,
              cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
              likeOrDislike: () => context.read<TasksBloc>().add(
                    MarkFavouriteOrUnfavoriteTask(task: task),
                  ),
              editTaskCallback: () {
                _editTask(context);
              },
              restoreTaskCallback: () =>
                  context.read<TasksBloc>().add(RestoreTask(task: task)),
            ),
          ],
        ),
      ],
    );
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTasksWidget(
                  oldTask: task,
                ),
              ),
            ));
  }
}
