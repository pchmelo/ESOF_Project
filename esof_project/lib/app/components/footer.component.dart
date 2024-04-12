import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isCurrentRoute = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/storage') {
              Navigator.pushReplacementNamed(context, '/start/storage');
            }
          },
          icon: const Icon(Icons.storage),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/shopping_list') {
              Navigator.pushReplacementNamed(context, '/start/shopping_list');
            }
          },
          icon: const Icon(Icons.list),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/calendar') {
              Navigator.pushReplacementNamed(context, '/start/calendar');
            }
          },
          icon: const Icon(Icons.calendar_month),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/settings') {
              Navigator.pushReplacementNamed(context, '/start/settings');
            }
          },
          icon: const Icon(Icons.settings),
          iconSize: 40,
        ),
      ]),
    );
  }
}
