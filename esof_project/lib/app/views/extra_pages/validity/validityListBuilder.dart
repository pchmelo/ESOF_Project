import 'package:esof_project/app/views/extra_pages/validity/validityTile.dart';
import 'package:flutter/material.dart';

import '../../../models/validity.model.dart';

class ValidityListBuilder extends StatefulWidget {
  final ValueNotifier<bool> editValidity;
  final List<Map<String, dynamic>> foundProducts;
  late ValidityTile validityTile;
  ValidityListBuilder(
      {super.key,
      required this.foundProducts,
      required this.editValidity,
      required this.validityTile});

  @override
  State<ValidityListBuilder> createState() => _ValidityListBuilderState();
}

class _ValidityListBuilderState extends State<ValidityListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.foundProducts.length,
      itemBuilder: (context, index) {
        widget.validityTile = ValidityTile.withValidity(
          validity: Validity.fromJson(
            widget.foundProducts[index],
          ),
          editValidity: widget.editValidity,
        );

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: widget.validityTile),
        );
      },
    );
    ;
  }
}
