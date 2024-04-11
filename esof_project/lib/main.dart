import 'package:esof_project/app/views/main_pages/calendar.view.dart';
import 'package:esof_project/app/views/main_pages/settings.view.dart';
import 'package:esof_project/app/views/main_pages/shopping_list.view.dart';
import 'package:esof_project/app/views/main_pages/storage.view.dart';
import 'package:esof_project/app/views/start.view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/start',
      routes: {
        '/start': (context) => Start(),
        '/start/storage': (context) => StorageView(),
        '/start/calendar': (context) => CalanderView(),
        '/start/settings': (context) => SettingsView(),
        '/start/shopping_list': (context) => ShoppingListView(),
      },
    );
  }
}
