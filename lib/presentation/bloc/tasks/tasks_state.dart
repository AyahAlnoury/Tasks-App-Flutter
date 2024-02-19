part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> complatedTasks;

  final List<TaskModel> favoriteTasks;

  final List<TaskModel> removedTasks;
  const TasksState({
    this.pendingTasks = const <TaskModel>[],
    this.complatedTasks = const <TaskModel>[],
    this.favoriteTasks = const <TaskModel>[],
    this.removedTasks = const <TaskModel>[],
  });

  @override
  List<Object> get props => [
        pendingTasks,
        complatedTasks,
        favoriteTasks,
        removedTasks,
      ];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'complatedTasks': complatedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        pendingTasks: List<TaskModel>.from(
            map['pendingTasks']?.map((x) => TaskModel.fromMap(x))),
        complatedTasks: List<TaskModel>.from(
            map['complatedTasks']?.map((x) => TaskModel.fromMap(x))),
        favoriteTasks: List<TaskModel>.from(
            map['favoriteTasks']?.map((x) => TaskModel.fromMap(x))),
        removedTasks: List<TaskModel>.from(
            map['removedTasks']?.map((x) => TaskModel.fromMap(x))));
  }
}
