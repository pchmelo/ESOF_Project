import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final currentRoute;

  const Footer({
    super.key,
    this.currentRoute,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.storage),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.list),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.calendar_month),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          iconSize: 40,
        ),
      ]),
    );
  }
}
