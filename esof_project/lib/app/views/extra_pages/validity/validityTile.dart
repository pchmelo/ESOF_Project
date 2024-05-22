import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:esof_project/app/views/extra_pages/validity/editValidity.widget.dart';
import 'package:flutter/material.dart';
import '../../../models/validity.model.dart';

class ValidityTile extends StatefulWidget {
  final ValueNotifier<bool> editValidity;
  final ValidityNotifier validity;

  Map<String, Validity> _values = {};

  Map<String, bool> _delete = {};

  Map<String, Validity> getValue() {
    return _values;
  }

  Map<String, bool> getDelete() {
    return _delete;
  }

  ValidityTile()
      : validity = ValidityNotifier(Validity()),
        editValidity = ValueNotifier<bool>(false),
        super();

  ValidityTile.withValidity(
      {Key? key, required Validity validity, required this.editValidity})
      : validity = ValidityNotifier(validity),
        super(key: key);

  @override
  State<ValidityTile> createState() => _ValidityTileState();
}

class _ValidityTileState extends State<ValidityTile> {
  final ValueNotifier<bool> deleteValidity = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    widget._delete[widget.validity.value.uid] = deleteValidity.value;
    widget._values[widget.validity.value.uid] = widget.validity.value;

    EditValidity widgetEditValidity =
        EditValidity(validity: widget.validity.value);
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.validity.value.name,
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text('Quantity: ${widget.validity.value.quantity}'),
                    Text(
                        'Expiration date: ${widget.validity.value.day}/${widget.validity.value.month}/${widget.validity.value.year}'),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: widget.editValidity,
                builder: (context, bool value, child) {
                  return value
                      ? Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await ValidityForm(
                                  context: context,
                                ).EditValidityForm(
                                    widget.validity.value, widgetEditValidity);

                                Validity new_one =
                                    widgetEditValidity.getValidity();

                                ValidityController validityController =
                                    ValidityController();

                                int difference = new_one.quantity -
                                    widget.validity.value.quantity;

                                validityController.updateValidity(
                                    new_one, difference);
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
                                    widget._delete[widget.validity.value.uid] =
                                        deleteValidity.value;
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
