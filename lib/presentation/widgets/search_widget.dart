import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/presentation/widgets/tasks_list_widgets.dart';

class customSearch extends SearchDelegate {
  List<TaskModel> filterList = [];
  List<TaskModel> searchList;
  customSearch({required this.searchList});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return TasksList(taskList: searchList);
    } else {
      filterList = searchList
          .where((element) =>
              element.title.toLowerCase().startsWith(query.toLowerCase()) ||
              element.description.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
      return TasksList(taskList: filterList);
    }
  }
}
