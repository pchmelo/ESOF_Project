import 'package:esof_project/app/views/main_pages/addProduct/barScanner.view.dart';
import 'package:esof_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../components/productForm.component.dart';
import '../../../controllers/ProductControllers.dart';
import '../../../models/product.model.dart';

class BarCodeProcess extends StatefulWidget {
  final Function change_quantity_controller =
      ProductControllers().ChangeQuantityProduct;
  final String barCode;
  BarCodeProcess({super.key, required this.barCode});

  @override
  State<BarCodeProcess> createState() => _BarCodeProcessState();
}

class _BarCodeProcessState extends State<BarCodeProcess> {
  late DatabaseService _dbService;
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseService(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    /*
    final Function controller =
        ProductForm(context: context).AddProductQuantityForm;

     */
    return FutureBuilder<Product?>(
      future: _dbService.getProductByBarcode(widget.barCode),
      builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (snapshot.hasData) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ProductForm(context: context).AddProductQuantityForm(
                snapshot.data, widget.change_quantity_controller);
          });
          return Container();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Not Found'),
            ),
            body: Center(
              child: Text('Chora baby! ${widget.barCode}'),
            ),
          );
        }
      },
    );
  }
}
