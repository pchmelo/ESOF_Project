import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:esof_project/services/notificationService.dart';
import 'package:flutter/material.dart';

import '../../../controllers/productControllers.dart';
import '../../extra_pages/product/product.view.dart';

class StorageView extends StatefulWidget {
  static const name = 'Storage';

  const StorageView({super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  final create_controller = ProductControllers().CreateProduct;

  final edit_controller = ProductControllers().EditProduct;

  static const name = 'Storage';
  String currentRoute = '/start/storage';

  @override
  Widget build(BuildContext context) {
    void handleProductTap(product, controller) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProducDetailsPage(product: product, controller: controller)));
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          child: const Icon(Icons.add_circle_outline),
          onPressed: () {
            return ProductForm(context: context)
                .CreateProductForm(create_controller);
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            name,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 31,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductList(
                    handleProductTap: handleProductTap,
                    controller: edit_controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
