import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavouriteOrUnfavoriteTask>(_onMArkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      complatedTasks: state.complatedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> complatedTasks = state.complatedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            complatedTasks = List.from(complatedTasks)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            complatedTasks = List.from(complatedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };
    emit(TasksState(
      pendingTasks: pendingTasks,
      complatedTasks: complatedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: state.pendingTasks,
      complatedTasks: state.complatedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(
            event.task,
          ),
        complatedTasks: List.from(state.complatedTasks)
          ..remove(
            event.task,
          ),
        favoriteTasks: List.from(state.favoriteTasks)
          ..remove(
            event.task,
          ),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }

  void _onMArkFavoriteOrUnfavoriteTask(
      MarkFavouriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> complatedTasks = state.complatedTasks;

    List<TaskModel> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = complatedTasks.indexOf(event.task);
        complatedTasks = List.from(complatedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = complatedTasks.indexOf(event.task);
        complatedTasks = List.from(complatedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      complatedTasks: complatedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> favouriteTasks = state.favoriteTasks;

    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        complatedTasks: state.complatedTasks..remove(event.oldTask),
        favoriteTasks: favouriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            )),
      complatedTasks: state.complatedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      complatedTasks: state.complatedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }
}
