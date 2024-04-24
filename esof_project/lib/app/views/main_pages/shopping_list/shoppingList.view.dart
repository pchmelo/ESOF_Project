import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productListForm.component.dart';
import 'package:esof_project/app/controllers/shoppingListControllers.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListDisplay.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingList.widgetViewList.dart';
import 'package:flutter/material.dart';

class ShoppingListView extends StatelessWidget {
  final name = 'Shopping Lists';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(name),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/shopping_cart.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShoppingListViewList(
                controller: create_controller,
                handleShoppingListTap: handleShoppingListTap)
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
