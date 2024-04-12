import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

class StorageView extends StatelessWidget {
  static const name = 'Storage';
  String currentRoute = '/start/storage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: const Text(name),
          ),
          const SizedBox(height: 600),
          Footer(),
        ],
      ),
    );
  }
}
