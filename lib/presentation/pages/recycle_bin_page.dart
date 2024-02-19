import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/presentation/pages/my_drawer_page.dart';
import 'package:tasks_app/presentation/widgets/tasks_list_widgets.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:hydrated_bloc/hydrated_bloc.dart';

class RecycleBinPage extends StatelessWidget {
  const RecycleBinPage({
    super.key,
  });
  static const id = 'recycle_bin_page';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(),
          drawer: MyDrawerPage(),
          body: BodyWidget(state),
        );
      },
    );
  }

  Column BodyWidget(TasksState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Chip(
            label: Text(
              '${state.removedTasks.length}Tasks',
            ),
          ),
        ),
        TasksList(
          taskList: state.removedTasks,
        )
      ],
    );
  }

  AppBar AppBarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 44, 151, 209),
      title: const Text('Recycle Bin'),
      actions: [
        PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete_forever),
                        label: const Text('Delete all tasks'),
                      ),
                      onTap: () =>
                          context.read<TasksBloc>().add(DeleteAllTasks())),
                ])
      ],
    );
  }
}
