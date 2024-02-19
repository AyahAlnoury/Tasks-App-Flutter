import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

class PopupMenu extends StatelessWidget {
  final TaskModel task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  const PopupMenu({
    super.key,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislike,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
    required this.task,
  });
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: editTaskCallback,
                      icon: Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    onTap: editTaskCallback,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? Icon(Icons.bookmark_add_outlined)
                          : Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text('Add to Bookmarks')
                          : const Text('Remove from Bookmarks'),
                    ),
                    onTap: likeOrDislike,
                  ),
                  PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                        label: const Text('Delete'),
                      ),
                      onTap: cancelOrDeleteCallback)
                ]
            : (context) => [
                  PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.restore_from_trash),
                        label: const Text('Restore'),
                      ),
                      onTap: restoreTaskCallback),
                  PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete_forever),
                        label: const Text('Delete Forever'),
                      ),
                      onTap: cancelOrDeleteCallback)
                ]);
  }
}
