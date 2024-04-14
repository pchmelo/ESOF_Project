import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/views/main_pages/storage/createProduct.widget.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:flutter/material.dart';

class StorageView extends StatelessWidget {
  static const name = 'Storage';
  String currentRoute = '/start/storage';

  @override
  Widget build(BuildContext context) {
    void _createProductForm() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const CreateProdut(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProductList(),
          IconButton(
              onPressed: () {
                return _createProductForm();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
