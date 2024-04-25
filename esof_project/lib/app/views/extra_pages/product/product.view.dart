import 'package:esof_project/app/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../services/database_product.dart';
import '../../../components/productForm.component.dart';
import '../../../controllers/shoppingListControllers.dart';
import '../../main_pages/shopping_list/shoppingList.widgetViewList.dart';
import '../list_products/shoppingListDisplay.dart';

class ProducDetailsPage extends StatelessWidget {
  final Function controller;
  final Product product;
  const ProducDetailsPage(
      {super.key, required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    Future<void> deleteProduct() async {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseForProducts dbService = DatabaseForProducts(uid: user.uid);

      await dbService.deleteProductById(product.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Info'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: const Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      child: Icon(Icons.edit),
                    ),
                    Text('Edit'),
                  ],
                ),
                onTap: () async {
                  await ProductForm(product: product, context: context)
                      .EditProductForm(controller);
                  Navigator.pop(context);
                },
              ),
              PopupMenuItem<int>(
                value: 1,
                child: const Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      child: Icon(Icons.delete),
                    ),
                    Text('Delete'),
                  ],
                ),
                onTap: () {
                  deleteProduct();
                },
              ),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const SizedBox(
            height: 100,
            width: 100,
            child: Placeholder(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Center(
                    child: Text(
                      '${product.name}',
                      style: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Center(
                    child: Text(
                      'Threshold: ${product.threshold}',
                      style: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Quantity: ${product.quantity}',
                    style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShoppingListForm(context: context)
                                  .SelectShoppingListForm(this.product)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(50.0, 50.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Decreasing border radius
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_basket_outlined),
                  iconSize: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

SelectedItem(BuildContext context, item) async {
  switch (item) {
    case 0:
      print('Edit');
      break;
    case 1:
      Navigator.pop(context);
      break;
  }
}
