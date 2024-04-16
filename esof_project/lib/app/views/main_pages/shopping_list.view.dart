import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

class ShoppingListView extends StatelessWidget {
  final name = 'Shopping List';
  String currentRoute = '/start/shopping_list';

  ShoppingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Transform.rotate(
              angle: -0.785,
              child: const Text('IN PROGRESS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 50))),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
