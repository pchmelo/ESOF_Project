import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityList.widget.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/productForm.component.dart';

class ProducDetailsPage extends StatefulWidget {
  final Function controller;
  final Product product;
  final Function controller_delete = ProductControllers().deleteProduct;
  ProducDetailsPage(
      {super.key, required this.product, required this.controller});

  final ValidityTile validityTile = ValidityTile();

  @override
  _ProducDetailsPageState createState() => _ProducDetailsPageState();
}

class _ProducDetailsPageState extends State<ProducDetailsPage> {
  bool isInProductInfo = true;
  ValueNotifier<bool> editValidity = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.product.validity
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (!isInProductInfo) {
                        setState(() {
                          isInProductInfo = true;
                        });
                      }
                    },
                    child: Text(
                      'Product Info',
                      style: TextStyle(
                        fontSize: 10,
                        decoration:
                            isInProductInfo ? TextDecoration.underline : null,
                      ),
                    ),
                  ),
                  const Text(' | ', style: TextStyle(fontSize: 10)),
                  TextButton(
                    onPressed: () {
                      if (isInProductInfo) {
                        setState(() {
                          isInProductInfo = false;
                        });
                      }
                    },
                    child: Text(
                      'Expiration Dates',
                      style: TextStyle(
                        fontSize: 10,
                        decoration:
                            isInProductInfo ? null : TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'Product Info',
                  style: TextStyle(fontSize: 10),
                ),
              ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[
                    ValueListenableBuilder(
                      valueListenable: editValidity,
                      builder: (context, bool value, child) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                          child: Icon(value ? Icons.cancel : Icons.edit),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: editValidity,
                      builder: (context, bool value, child) {
                        return Text(value ? 'Cancel' : 'Edit');
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  if (isInProductInfo) {
                    await ProductForm(product: widget.product, context: context)
                        .EditProductForm(widget.controller);
                    Navigator.pop(context);
                  } else {
                    editValidity.value = !editValidity.value;
                  }
                },
              ),
              if (isInProductInfo) // Add this condition
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
                    widget.controller_delete(widget.product.id);
                  },
                ),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
        ],
      ),
      body: isInProductInfo
          ? Column(
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
                            widget.product.name,
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
                            'Threshold: ${widget.product.threshold}',
                            style: const TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Quantity: ${widget.product.quantity}',
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
                                builder: (context) => ShoppingListForm(
                                        context: context)
                                    .SelectShoppingListForm(widget.product)),
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
                              borderRadius: BorderRadius.circular(50.0),
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
            )
          : Column(
              children: [
                Expanded(
                  child: ValidityListWidget(
                      validityTile: widget.validityTile,
                      product: widget.product,
                      editValidity: editValidity),
                ),
                ValueListenableBuilder(
                  valueListenable: editValidity,
                  builder: (context, bool value, child) {
                    return value
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () async {},
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
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
