part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final TaskModel task;

  AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  final TaskModel task;

  UpdateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TasksEvent {
  final TaskModel task;

  RemoveTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final TaskModel task;

  DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class MarkFavouriteOrUnfavoriteTask extends TasksEvent {
  final TaskModel task;

  const MarkFavouriteOrUnfavoriteTask({required this.task});
  @override
  List<Object> get props => [task];
}

class EditTask extends TasksEvent {
  final TaskModel oldTask;
  final TaskModel newTask;

  EditTask({
    required this.oldTask,
    required this.newTask,
  });
  @override
  List<Object> get props => [
        oldTask,
        newTask,
      ];
}

class RestoreTask extends TasksEvent {
  final TaskModel task;

  RestoreTask({
    required this.task,
  });
  @override
  List<Object> get props => [task];
}

class DeleteAllTasks extends TasksEvent {}
