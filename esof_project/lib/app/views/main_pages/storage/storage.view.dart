import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
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

  static const name = 'STORAGE';
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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          return ProductForm(context: context)
              .CreateProductForm(create_controller);
        },
      ),
      appBar: AppBar(
        title: const Text(
          name,
          style: TextStyle(
            fontFamily: 'CrimsonPro',
            fontSize: 31,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/boxes_background.png"),
            fit: BoxFit.cover,
          ),
        ),
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
      bottomNavigationBar: const Footer(),
    );
  }
}
