import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

class StorageView extends StatelessWidget {
  final name = 'Storage';
  final currentRoute = '/start/storage';

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
          Container(
            child: Text(name),
          ),
          const SizedBox(height: 600),
          const Footer(),
        ],
      ),
    );
  }
}
