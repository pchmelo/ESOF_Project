import 'dart:typed_data';
import 'package:esof_project/app/components/notificationForm.component.dart';
import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/validity/validityList.widget.dart';
import 'package:esof_project/services/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/image_selector.dart';
import '../../../components/productForm.component.dart';
import '../../../models/notication.model.dart';

class ProducDetailsPage extends StatefulWidget {
  final Function controller;
  Product product;
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

  void initState() {
    super.initState();
    fetchProduct();
  }

  fetchProduct() async {
    ProductControllers productController = ProductControllers();
    Product updatedProduct =
        await productController.fetchProduct(widget.product);
    setState(() {
      widget.product = updatedProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.product.validity
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (!isInProductInfo) {
                        ProductControllers productController =
                            ProductControllers();
                        Product updatedProduct = await productController
                            .getProductById(widget.product.id);

                        setState(() {
                          widget.product = updatedProduct;
                          isInProductInfo = true;
                        });
                      }
                    },
                    child: Text(
                      'Product Info',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                        color: isInProductInfo ? Colors.amber : Colors.black,
                      ),
                    ),
                  ),
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
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                        color: isInProductInfo ? Colors.black : Colors.amber,
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'Product Info',
                  style: TextStyle(fontSize: 20),
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
                    ProductControllers productController = ProductControllers();
                    Product updatedProduct = await productController
                        .getProductById(widget.product.id);

                    setState(() {
                      widget.product = updatedProduct;
                    });
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
                  onTap: () => selectIcon(ImageSource.camera),
                  child: const Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: Icon(Icons.camera_alt),
                      ),
                      Text('Change Icon From Camera'),
                    ],
                  ),
                ),
              if (isInProductInfo)
              PopupMenuItem<int>(
                value: 3,
                onTap: () => selectIcon(ImageSource.gallery),
                child: const Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      child: Icon(Icons.photo_library),
                    ),
                    Text('Change Icon From Gallery'),
                  ],
                ),
              ),
              if (widget.product.notification)
                PopupMenuItem<int>(
                  value: 4,
                  child: const Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: Icon(Icons.notifications),
                      ),
                      Text('Edit Notification'),
                    ],
                  ),
                  onTap: () async {
                    NotificationModel? notification =
                        await NotificationController()
                            .findNotificationByProduct(widget.product);
                    await NotificationForm(context: context)
                        .updateNotificationForm(widget.product, notification!);
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
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(widget.product.imageURL),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Center(
                          child: Text(
                            'Quantity: ${widget.product.quantity}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: Center(
                          child: Text(
                            'Threshold: ${widget.product.threshold}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            await ShoppingListForm(context: context)
                                .SelectShoppingListForm(widget.product);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(70.0, 70.0),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(5.0),
                          ),
                          child: const Icon(
                            Icons.shopping_basket_outlined,
                            size: 50.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: widget.product.validity
                            ? Container()
                            : ElevatedButton(
                                onPressed: () async {
                                  await ProductForm(
                                          product: widget.product,
                                          context: context)
                                      .removeQuantityForm();
                                  fetchProduct();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.redAccent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(70.0, 70.0),
                                  ),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(5.0),
                                ),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 50.0,
                                ),
                              ),
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

  void selectIcon(ImageSource src) async {
    Uint8List cameraIcon = await selectImage(src);

    productIcon = cameraIcon;

    if (productIcon != null) {
      saveIcon();
    }
  }

  void saveIcon() async {
    String imageURL = await UploadData()
        .uploadImage('products/${widget.product.id}/icon', productIcon!);
    ProductControllers productController = ProductControllers();
    await productController.updateImageURL(widget.product, imageURL);

    Product newProduct =
        await productController.getProductById(widget.product.id);

    setState(() {
      widget.product = newProduct;
    });
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
