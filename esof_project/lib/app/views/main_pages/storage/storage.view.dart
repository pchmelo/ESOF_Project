import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/views/main_pages/storage/createProduct.widget.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:flutter/material.dart';

import '../../../controllers/ProductControllers.dart';
import '../../extra_pages/product.view.dart';

class StorageView extends StatelessWidget {
  final create_controller = ProductControllers().CreateProduct;
  final edit_controller = ProductControllers().EditProduct;

  static const name = 'STORAGE';
  String currentRoute = '/start/storage';

  StorageView({super.key});

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
        title: const Text(name,
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/boxes_background.png"), fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductList(
                handleProductTap: handleProductTap, controller: edit_controller),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
