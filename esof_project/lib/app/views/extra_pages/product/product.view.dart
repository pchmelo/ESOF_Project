import 'dart:io';
import 'dart:typed_data';

import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityList.widget.dart';
import 'package:esof_project/services/upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/image_selector.dart';
import '../../../components/productForm.component.dart';

class ProducDetailsPage extends StatefulWidget {
  final Function controller;
  final Product product;
  final Function controller_delete = ProductControllers().deleteProduct;
  ProducDetailsPage(
      {super.key, required this.product, required this.controller});
  @override
  _ProducDetailsPageState createState() => _ProducDetailsPageState();
}

class _ProducDetailsPageState extends State<ProducDetailsPage> {
  bool isInProductInfo = true;
  ValueNotifier<bool> editValidity = ValueNotifier<bool>(false);

  Uint8List? productIcon;

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
                        if (value && !isInProductInfo) {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: Icon(Icons.cancel),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: Icon(Icons.edit),
                          );
                        }
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: editValidity,
                      builder: (context, bool value, child) {
                        if (value && !isInProductInfo) {
                          return const Text('Cancel');
                        } else {
                          return const Text('Edit');
                        }
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
              if (isInProductInfo)
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
              if (isInProductInfo)
              PopupMenuItem<int>(
                value: 2,
                onTap: selectIconCamera,
                child: const Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      child: Icon(Icons.camera_alt),
                    ),
                    Text('Change Icon'),
                  ],
                ),
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
                SizedBox(
                  height: 100,
                  width: 100,
                  child: productIcon != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(productIcon!),
                          radius: 50,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/food.png'),
                          radius: 50,
                        ),
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
                      product: widget.product, editValidity: editValidity),
                ),
              ],
            ),
    );
  }

  void selectIconCamera() async {
    Uint8List cameraIcon = await selectImage(ImageSource.camera);

    setState(() {
      productIcon = cameraIcon;
    });

    if (productIcon != null) {
      saveIcon();
    }
  }

  void saveIcon() async{
    String resp = await UploadData().saveImage(image: productIcon!);
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