import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/pages/add_chart_page.dart';
import 'package:tasks_app/presentation/pages/complated_tasks_page.dart';
import 'package:tasks_app/presentation/pages/favorate_tasks_page.dart';
import 'package:tasks_app/presentation/pages/my_drawer_page.dart';
import 'package:tasks_app/presentation/pages/pending_tasks_page.dart';

import '../widgets/add_task_widget.dart';

class TabsPage extends StatefulWidget {
  TabsPage({super.key});
  static const id = 'tabs_page';

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'PageName': PendingTasksPage(), 'title': 'Pending Tasks'},
    {'PageName': AddChartPage(), 'title': 'Add Tasks'},
    {'PageName': ComplatedTasksPage(), 'title': 'Complated Tasks'},
    {'PageName': FavoriteTasksPage(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerPage(),
      body: _pageDetails[_selectedPageIndex]['PageName'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 44, 151, 209),
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        iconSize: 24.0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp, size: 30),
              label: 'Pending Tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Tasks',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 30), label: 'Complated Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30), label: 'Favorite Tasks'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 64, 59, 59),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        unselectedFontSize: 12,
      ),
    );
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
