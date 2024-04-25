import 'package:esof_project/app/shared/loading.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:esof_project/services/database_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../components/productForm.component.dart';
import '../../../controllers/productControllers.dart';
import '../../../models/product.model.dart';

class BarCodeProcess extends StatefulWidget {
  final Function change_quantity_controller =
      ProductControllers().ChangeQuantityProduct;

  final Function change_quantity_controller_scan =
      ProductControllers().ChangeQuantityProduct;

  final String barCode;
  BarCodeProcess({super.key, required this.barCode});

  @override
  State<BarCodeProcess> createState() => _BarCodeProcessState();
}

class _BarCodeProcessState extends State<BarCodeProcess> {
  late DatabaseForProducts _dbService;
  late User user;

  void handleProductTap(Product product, Function controller) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: ProductForm(context: context).AddProductQuantityForm(
                  "", controller, product, widget.barCode),
            ),
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseForProducts(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product?>(
      future: _dbService.getProductByBarcode(widget.barCode),
      builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Loading());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (snapshot.hasData) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ProductForm(context: context).AddProductQuantityForm(
                "0", widget.change_quantity_controller, snapshot.data, '');
          });
          return Container();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Choose the product to add the new scan code'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductList(
                    handleProductTap: handleProductTap,
                    controller: widget.change_quantity_controller),
              ],
            ),
          );
        }
      },
    );
  }
}
