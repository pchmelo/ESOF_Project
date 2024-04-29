import 'package:esof_project/app/views/extra_pages/validity/validityTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/validityControllers.dart';
import '../../../models/validity.model.dart';

class ValidityListBuilder extends StatefulWidget {
  final ValueNotifier<bool> editValidity;
  final List<Map<String, dynamic>> foundValidities;
  ValidityTile? validityTile;

  ValidityListBuilder({
    super.key,
    required this.foundValidities,
    required this.editValidity,
  });

  @override
  State<ValidityListBuilder> createState() => _ValidityListBuilderState();
}

class _ValidityListBuilderState extends State<ValidityListBuilder> {
  List<Map<String, bool>> list_delete = [];
  List<Map<String, Validity>> list_validity = [];
  List<ValidityTile> validityTiles = [];

  void getDeleteValidityFromTiles() {
    for (var validityTile in validityTiles) {
      list_delete.add(validityTile.getDelete());
    }
  }

  void getValuesValidityFromTiles() {
    for (var validityTile in validityTiles) {
      list_validity.add(validityTile.getValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.foundValidities.length,
            itemBuilder: (context, index) {
              widget.validityTile = ValidityTile.withValidity(
                validity: Validity.fromJson(
                  widget.foundValidities[index],
                ),
                editValidity: widget.editValidity,
              );

              validityTiles.add(widget.validityTile!);

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
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.editValidity,
          builder: (context, bool value, child) {
            return value
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () async {
                        ValidityController validityController =
                            ValidityController();
                        getDeleteValidityFromTiles();

                        for (var entry in list_delete) {
                          if (entry.values.first) {
                            await validityController
                                .deleteValidity(entry.keys.first);
                          }
                        }
                        widget.editValidity.value = false;
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ],
    );
    ;
  }
}
