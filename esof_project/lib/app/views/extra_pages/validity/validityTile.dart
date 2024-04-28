import 'package:flutter/material.dart';

import '../../../models/validity.model.dart';

class ValidityTile extends StatelessWidget {
  final ValueNotifier<bool> editValidity;
  final ValueNotifier<bool> deleteValidity = ValueNotifier<bool>(false);
  final Validity validity;

  ValidityTile()
      : validity = Validity(), // Replace with a default Validity object
        editValidity = ValueNotifier<bool>(false),
        super();

  ValidityTile.withValidity(
      {Key? key, required this.validity, required this.editValidity})
      : super(key: key);

  Map<String, ValidityTile> _values = {};
  Map<String, bool> _delete = {};

  Validity? getValue(String validityId) {
    return _values[validityId]?.validity;
  }

  bool getDelete(String validityId) {
    return _delete[validityId] ?? false;
  }

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(validity.name),
                    Text('Quantity: ${validity.quantity}'),
                    Text(
                        'Expiration date: ${validity.day}/${validity.month}/${validity.year}'),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: editValidity,
                builder: (context, bool value, child) {
                  return value
                      ? Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Handle your edit action here
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: deleteValidity,
                              builder: (context, bool value, child) {
                                return IconButton(
                                  icon:
                                      Icon(value ? Icons.close : Icons.delete),
                                  onPressed: () {
                                    deleteValidity.value =
                                        !deleteValidity.value;
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
