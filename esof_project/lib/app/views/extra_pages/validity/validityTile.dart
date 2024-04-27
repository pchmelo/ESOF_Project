import 'package:flutter/material.dart';

import '../../../models/validity.model.dart';

class ValidityTile extends StatelessWidget {
  final Validity validity;
  const ValidityTile({super.key, required this.validity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.yellow[100],
                    backgroundImage: const AssetImage(
                        'assets/images/default_product_image.png'),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(validity.name),
                  Text('Quantity: ${validity.quantity}'),
                  Text(
                      'Expiration date: ${validity.day}/${validity.month}/${validity.year}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
