import 'package:esof_project/app/views/main_pages/addProduct/addProduct.view.dart';
import 'package:esof_project/app/views/main_pages/addProduct/barScanner.view.dart';
import 'package:esof_project/app/views/main_pages/calendar.view.dart';
import 'package:esof_project/app/views/main_pages/settings.view.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingList.view.dart';
import 'package:esof_project/app/views/main_pages/storage/storage.view.dart';
import 'package:esof_project/app/views/wrapper.dart';
import 'package:esof_project/services/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/components/transitionAnimation.component.dart';
import 'app/models/user.mode.dart';
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: MyUser(uid: null),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/start',
        onGenerateRoute: (route) => onGenerateRoute(route),
      ),
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    String currentRoute = settings.name!;
    AxisDirection direction;
    int index;

    switch (currentRoute) {

      case '/start/storage':
        index = 0;
        break;
      case '/start/shopping_list':
        index = 1;
        break;
      case '/start/add_product':
        index = 2;
        break;
      case '/start/calendar':
        index = 3;
        break;
      case '/start/settings':
        index = 4;
        break;
      default:
        index = -1;
    }

    switch (settings.name) {
      case '/start':
        return MaterialPageRoute(builder: (context) => Wrapper());
      case '/start/storage':
        if (index > 0) {
          direction  = AxisDirection.left;
        }
        else {
          direction = AxisDirection.right;
        }

        return CustomPageRoute(
          child: const StorageView(),
          direction: direction,
          settings: settings,
        );
      case '/start/calendar':
        if (index > 3) {
          direction = AxisDirection.left;
        }
        else {
          direction = AxisDirection.right;
        }

        return CustomPageRoute(
          child: const CalenderView(),
          direction: direction,
          settings: settings,
        );
      case '/start/settings':
        if (index > 4) {
          direction = AxisDirection.left;
        }
        else {
          direction = AxisDirection.right;
        }

        return CustomPageRoute(
          child: SettingsView(),
          direction: direction,
          settings: settings,
        );
      case '/start/add_product':
        if (index > 2) {
          direction = AxisDirection.left;
        }
        else {
          direction = AxisDirection.right;
        }

        return CustomPageRoute(
          child: AddProductView(),
          direction: direction,
          settings: settings,
        );
      case '/start/shopping_list':
        if (index > 1) {
          direction = AxisDirection.left;
        }
        else {
          direction = AxisDirection.right;
        }

        return CustomPageRoute(
          child: ShoppingListView(),
          direction: direction,
          settings: settings,
        );
      case '/start/add_product/bar_scanner':
        return CustomPageRoute(
          child: const BarScannerView(),
          direction: AxisDirection.up,
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (context) => Wrapper());
    }
  }
}
