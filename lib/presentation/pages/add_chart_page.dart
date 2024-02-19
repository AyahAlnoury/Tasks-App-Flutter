import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:tasks_app/presentation/pages/my_drawer_page.dart';
import 'package:tasks_app/presentation/widgets/add_task_widget.dart';
import 'package:tasks_app/presentation/widgets/pie_chart_widget.dart';
import 'package:tasks_app/presentation/widgets/search_widget.dart';

class AddChartPage extends StatelessWidget {
  const AddChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<TaskModel> taskList = state.pendingTasks;
      return Scaffold(
        appBar: AppBarWidget(context, taskList),
        drawer: MyDrawerPage(),
        body: BodyWidget(state, taskList, context),
      );
    });
  }

  Column BodyWidget(
      TasksState state, List<TaskModel> taskList, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 5,
                left: 5,
              ),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "PROGRESS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Task/Project progress you assign"),
                    PieChartSample(
                      complatedLength: state.complatedTasks.length.toDouble(),
                      pendingLength: taskList.length.toDouble(),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipOval(
                          child: Container(
                              color: Colors.red, width: 15, height: 15),
                        ),
                      ),
                      Text("   Pending"),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ClipOval(
                          child: Container(
                              color: Color.fromARGB(255, 44, 151, 209),
                              width: 15,
                              height: 15),
                        ),
                      ),
                      Text("Complated"),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 44, 151, 209),
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            ),
          )
        ]);
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTasksWidget(),
              ),
            ));
  }
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
