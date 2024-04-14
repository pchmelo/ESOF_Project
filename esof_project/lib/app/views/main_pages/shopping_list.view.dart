import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

class ShoppingListView extends StatelessWidget {
  final name = 'Shopping List';
  String currentRoute = '/start/shopping_list';

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
          Text(name),
          const SizedBox(height: 600),
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
