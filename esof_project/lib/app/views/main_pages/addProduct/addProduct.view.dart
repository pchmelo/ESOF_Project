import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  final name = 'Add Product';
  String currentRoute = '/start/settings';

  AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/start/add_product/manual_add_product');
                },
                child: const Text('Add Product Manually')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/start/add_product/bar_scanner');
                },
                child: const Text('Bar Code Scan')),
            const SizedBox(height: 100),
            Transform.rotate(
                angle: -0.785,
                child: const Text(
                    'IN PROGRESS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50 )
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
