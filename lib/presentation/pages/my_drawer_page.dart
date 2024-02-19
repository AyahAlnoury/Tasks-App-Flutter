import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/bloc/switch/switch_bloc.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/presentation/pages/recycle_bin_page.dart';
import 'package:tasks_app/presentation/pages/tabs_page.dart';

class MyDrawerPage extends StatelessWidget {
  const MyDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Stack(children: [
                Container(
                    width: 200,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 44, 151, 209),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 110, top: 5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/girl.jpg"),
                    radius: 40,
                  ),
                ),
              ]),
            ),
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(TabsPage.id),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.folder_special),
                    title: Text('My Tasks'),
                    trailing: Text(
                        '${state.pendingTasks.length}| ${state.complatedTasks.length}'),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(RecycleBinPage.id),
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Bin'),
                  trailing: Text('${state.removedTasks.length}'),
                ),
              );
            },
          ),
          Divider(),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                  value: state.switchValiue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  });
            },
          ),
        ],
      ),
    ));
  }
}
