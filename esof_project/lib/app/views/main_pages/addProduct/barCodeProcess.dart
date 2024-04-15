import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/product.model.dart';

class BarCodeProcess extends StatefulWidget {
  final String barCode;
  const BarCodeProcess({super.key, required this.barCode});

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
    final Function controller =
        ProductForm(context: context).AddProductQuantityForm;

    return FutureBuilder<Product?>(
      future: _dbService.getProductByBarcode(widget.barCode),
      builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (snapshot.hasData) {
          return Expanded(
            child: ProductForm(context: context)
                .AddProductQuantityForm(snapshot.data!, controller // Product
                    ) as Widget,
          );
        } else {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed('/start/add_product/bar_scanner');
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product not found'),
            ),
          ); // Return an empty container while navigation is being prepared
        }
      },
    );
  }
}
