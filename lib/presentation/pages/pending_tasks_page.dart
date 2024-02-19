import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/presentation/pages/my_drawer_page.dart';
import 'package:tasks_app/presentation/widgets/search_widget.dart';
import 'package:tasks_app/presentation/widgets/tasks_list_widgets.dart';

class PendingTasksPage extends StatelessWidget {
  PendingTasksPage({
    Key? key,
  }) : super(key: key);
  static const id = 'tasks_page';
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<TaskModel> taskList = state.pendingTasks;
        return Scaffold(
          appBar: AppBarWidget(context, taskList),
          drawer: MyDrawerPage(),
          body: BodyWidget(taskList, state),
        );
      },
    );
  }

  Column BodyWidget(List<TaskModel> taskList, TasksState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Chip(
              label: Text(
                '${taskList.length} Pending | ${state.complatedTasks.length} Complated',
              ),
            ),
          ),
        ),
        TasksList(
          taskList: taskList,
        )
      ],
    );
  }

  AppBar AppBarWidget(BuildContext context, List<TaskModel> taskList) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: customSearch(
                    searchList: taskList,
                  ));
            },
            icon: Icon(Icons.search))
      ],
      backgroundColor: Color.fromARGB(255, 44, 151, 209),
      title: Text('Pending Tasks'),
      centerTitle: true,
    );
  }
}
