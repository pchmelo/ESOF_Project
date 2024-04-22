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
  late TextEditingController quantityController; // Declare the controller

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
    quantityController =
        TextEditingController(text: '$quantity'); // Initialize the controller
  }

  void updateQuantity(int change) {
    setState(() {
      quantity += change;
      quantityController.text = '$quantity'; // Update the controller
    });
    widget.onQuantityChanged(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red, // Set the background color to red
            border: Border.all(color: Colors.black), // Add this line
          ),
          child: IconButton(
            onPressed: () {
              if (quantity > 0) {
                updateQuantity(-1);
              }
            },
            icon: const Icon(
              Icons.remove,
              color: Colors.white, // Set the icon color to white
            ),
          ),
        ),
        Container(
          width: (quantity >= 10)
              ? 50
              : 25, // Adjust the width based on the quantity
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            controller: quantityController, // Use the controller
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
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green, // Set the background color to green
            border: Border.all(color: Colors.black), // Add this line
          ),
          child: IconButton(
            onPressed: () {
              updateQuantity(1);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white, // Set the icon color to white
            ),
          ),
        ),
      ],
    );
  }
}
