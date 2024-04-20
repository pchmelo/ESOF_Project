import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productListForm.component.dart';
import 'package:esof_project/app/controllers/shoppingListControllers.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListDisplay.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingList.widgetViewList.dart';
import 'package:flutter/material.dart';

class ShoppingListView extends StatelessWidget {
  final name = 'Shopping List';
  String currentRoute = '/start/shopping_list';

  ShoppingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final create_controller = ShoppingListControllers().CreateProduct;

    void handleShoppingListTap(shoppingList, controller) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShoppingListDisplay(
                  shoppingList: shoppingList, controller: controller)));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          return ProductListForm(context: context)
              .CreateProductForm(create_controller);
        },
      ),
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShoppingListViewList(
              controller: create_controller,
              handleShoppingListTap: handleShoppingListTap)
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
