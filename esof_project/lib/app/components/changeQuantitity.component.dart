import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ChangeQuantityComponent extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onQuantityChanged;

  ChangeQuantityComponent(
      {Key? key, required this.initialValue, required this.onQuantityChanged})
      : super(key: key);

  @override
  State<ChangeQuantityComponent> createState() =>
      _ChangeQuantityComponentState();
}

class _ChangeQuantityComponentState extends State<ChangeQuantityComponent> {
  late int quantity;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
    quantityController =
        TextEditingController(text: '$quantity');
  }

  void updateQuantity(int change) {
    setState(() {
      quantity += change;
      quantityController.text = '$quantity';
    });
    widget.onQuantityChanged(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (quantity > 0) {
                  updateQuantity(-1);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 30,
              ),
            ),
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: TextField(
                controller: quantityController,
                onSubmitted: (value) {
                  quantity = int.parse(value);
                  widget.onQuantityChanged(quantity);
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateQuantity(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

