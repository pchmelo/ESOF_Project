import 'package:flutter/material.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import '../controllers/productControllers.dart';
import '../../main.dart';


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
              navigationService.navigateTo('/start/storage');
            }
          },
          icon: const Icon(Icons.inbox_outlined),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/shopping_list') {
              navigationService.navigateTo('/start/shopping_list');            }
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
              navigationService.navigateTo('/start/calendar');
            }
          },
          icon: const Icon(Icons.calendar_month),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            String? currentRoute = ModalRoute.of(context)!.settings.name;
            if (currentRoute != '/start/settings') {
              navigationService.navigateTo('/start/settings');
            }
          },
          icon: const Icon(Icons.person_outline),
          iconSize: 40,
        ),
      ]),
    );
  }
}
