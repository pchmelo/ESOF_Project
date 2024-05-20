import 'package:flutter/material.dart';
import 'package:esof_project/app/components/productForm.component.dart';
import '../controllers/productControllers.dart';
import '../../main.dart';
import 'package:flutter/cupertino.dart';

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
    return Stack(
      children: [
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 60),
          painter: BNBCustomPainter(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    String? currentRoute =
                        ModalRoute.of(context)!.settings.name;
                    if (currentRoute != '/start/storage') {
                      navigationService.navigateTo('/start/storage');
                    }
                  },
                  icon: const Icon(
                    CupertinoIcons.cube_box,
                    color: Colors.black,
                  ),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () {
                    String? currentRoute =
                        ModalRoute.of(context)!.settings.name;
                    if (currentRoute != '/start/shopping_list') {
                      navigationService.navigateTo('/start/shopping_list');
                    }
                  },
                  icon: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.black,
                  ),
                  iconSize: 40,
                ),
                const SizedBox(
                  width: 60,
                ),
                IconButton(
                  onPressed: () {
                    String? currentRoute =
                        ModalRoute.of(context)!.settings.name;
                    if (currentRoute != '/start/calendar') {
                      navigationService.navigateTo('/start/calendar');
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () {
                    String? currentRoute =
                        ModalRoute.of(context)!.settings.name;
                    if (currentRoute != '/start/settings') {
                      navigationService.navigateTo('/start/settings');
                    }
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  iconSize: 40,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10, // adjust the position as needed
          left: MediaQuery.of(context).size.width / 2 - 28, // center the FAB
          child: FloatingActionButton(
            onPressed: () {
              String? currentRoute = ModalRoute.of(context)!.settings.name;
              if (currentRoute != '/start/add_product') {
                return ProductForm(context: context)
                    .PlusButtonForm(create_controller);
              }
            },
            child: const Icon(Icons.add_circle, color: Colors.black, size: 50),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[100]!
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(0, 0);
    path.lineTo(size.width * 0.5 - 26, 0);
    path.quadraticBezierTo(
        size.width * 0.5, size.height / 2 + 50.0, size.width * 0.5 + 26, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
