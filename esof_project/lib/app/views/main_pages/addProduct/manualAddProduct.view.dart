import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:flutter/material.dart';
import '../../../controllers/productControllers.dart';

class ManualProductView extends StatelessWidget {
  final name = 'Choose the Product you want to add to the Storage';
  String currentRoute = '/start/shopping_list';

  final Function change_quantity_controller =
      ProductControllers().ChangeQuantityProduct;

  ManualProductView({super.key});

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
          ProductList(
            handleProductTap: (product, controller) {
              ProductForm(context: context)
                  .AddProductQuantityForm(product, controller, '');
            },
            controller: change_quantity_controller,
          ),
        ],
      ),
    );
  }
}
