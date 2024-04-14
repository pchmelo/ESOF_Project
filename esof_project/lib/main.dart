import 'package:esof_project/app/views/extra_pages/product.view.dart';
import 'package:esof_project/app/views/main_pages/addProduct/addProduct.view.dart';
import 'package:esof_project/app/views/main_pages/addProduct/barScanner.view.dart';
import 'package:esof_project/app/views/main_pages/calendar.view.dart';
import 'package:esof_project/app/views/main_pages/settings.view.dart';
import 'package:esof_project/app/views/main_pages/shopping_list.view.dart';
import 'package:esof_project/app/views/main_pages/storage/storage.view.dart';
import 'package:esof_project/app/views/start.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/views/main_pages/addProduct/manualAddProduct.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyB16w7mImpCq4f4AW3aG2dSEeDNUZ4iRlc',
    appId: '1:21232196748:android:7235b69deec9d488162fa9',
    messagingSenderId: '21232196748',
    projectId: 'stockoverflow2-4f45a',
    storageBucket: 'stockoverflow2-4f45a.appspot.com',
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/start',
      routes: {
        '/start': (context) => Start(),
        '/start/storage': (context) => StorageView(),
        '/start/calendar': (context) => CalenderView(),
        '/start/settings': (context) => SettingsView(),
        '/start/add_product': (context) => AddProductView(),
        '/start/shopping_list': (context) => ShoppingListView(),
        '/start/add_product/bar_scanner': (context) => BarScannerView(),
        '/start/add_product/manual_add_product': (context) =>
            ManualProductView(),
      },
    );
  }
}
