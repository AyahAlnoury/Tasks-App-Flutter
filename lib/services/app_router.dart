import 'package:flutter/material.dart';
import 'package:tasks_app/presentation/pages/recycle_bin_page.dart';
import 'package:tasks_app/presentation/pages/tabs_page.dart';

class AppRouter {
  Route? onGenetateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinPage.id:
        return MaterialPageRoute(builder: (_) => RecycleBinPage());
      case TabsPage.id:
        return MaterialPageRoute(builder: (_) => TabsPage());
    }
    return null;
  }
}
