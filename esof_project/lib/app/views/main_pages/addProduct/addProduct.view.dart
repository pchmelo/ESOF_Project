import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

import '../../../controllers/productControllers.dart';
import 'manualAddProduct.view.dart';

class AddProductView extends StatelessWidget {
  final name = 'Add Product';
  final Function controller = ProductControllers().ChangeQuantityProduct;
  String currentRoute = '/start/settings';

  AddProductView({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 31,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManualProductView(
                              listUid: 0,
                              controller: controller,
                              spec: 'middle',
                            )));
              },
              child: const Text('Add Product Manually'),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/start/add_product/bar_scanner');
              },
              child: const Text('Bar Code Scan'),
            ),
            const SizedBox(height: 100),
            Transform.rotate(
              angle: -0.785,
              child: const Text('IN PROGRESS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 50)),
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: const Footer(),
  );
}
}