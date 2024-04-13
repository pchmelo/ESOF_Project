import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/views/main_pages/storage/createProduct.view.dart';
import 'package:flutter/material.dart';

class StorageView extends StatelessWidget {
  static const name = 'Storage';
  String currentRoute = '/start/storage';

  @override
  Widget build(BuildContext context) {
    void _createProductForm() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const CreateProdut(),
            );
          });
    }

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
          IconButton(
              onPressed: () {
                return _createProductForm();
              },
              icon: const Icon(Icons.add)),
          const SizedBox(height: 600),
          Footer(),
        ],
      ),
    );
  }
}
