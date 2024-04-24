import 'package:flutter/material.dart';
import '../controllers/ProductControllers.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import '../views/extra_pages/plusButton.widget.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isCurrentRoute = false;
  final create_controller = ProductControllers().PlusButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/storage') {
              Navigator.pushReplacementNamed(context, '/start/storage');
            }
          },
          icon: const Icon(Icons.inbox_outlined),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/shopping_list') {
              Navigator.pushReplacementNamed(context, '/start/shopping_list');
            }
          },
          icon: const Icon(Icons.shopping_basket_outlined),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/add_product') {
              return ProductForm(context: context)
                  .PlusButtonForm(create_controller);
            }
          },
          icon: const Icon(Icons.add_circle),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/calendar') {
              Navigator.pushReplacementNamed(context, '/start/calendar');
            }
          },
          icon: const Icon(Icons.calendar_month),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/settings') {
              Navigator.pushReplacementNamed(context, '/start/settings');
            }
          },
          icon: const Icon(Icons.person_outline),
          iconSize: 40,
        ),
      ]),
    );
  }
}
