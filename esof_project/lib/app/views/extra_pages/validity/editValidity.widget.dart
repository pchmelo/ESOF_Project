import 'package:esof_project/app/models/validity.model.dart';
import 'package:flutter/material.dart';
import '../../../components/changeQuantitity.component.dart';

class DateDisplay extends StatelessWidget {
  final DateTime date;
  DateDisplay({required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Selected Date: ${date.day}/${date.month}/${date.year}',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class EditValidity extends StatefulWidget {
  Validity validity;
  EditValidity({
    super.key,
    required this.validity,
  });

  Validity getValidity() {
    return validity;
  }

  @override
  State<EditValidity> createState() => _EditValidityState();
}

class _EditValidityState extends State<EditValidity> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _selectedDate = DateTime.now();
  int _quantity = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    _name = widget.validity.name;
    _quantity = widget.validity.quantity;
    super.initState();
    _selectedDate = DateTime(
      widget.validity.year,
      widget.validity.month,
      widget.validity.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: constraints.maxHeight * 0.83,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                'Edit the Expiration Date of ${widget.validity.name}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.validity.name,
                      decoration: const InputDecoration(
                        labelText: 'Expiration Date Name',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (val) => val!.isEmpty
                          ? 'Enter a name to the expiration date'
                          : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 60)),
                    const Text(
                      "Change the quantity of the expiration date",
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ChangeQuantityComponent(
                        initialValue: widget.validity.quantity,
                        onQuantityChanged: (quantity) {
                          _quantity = quantity;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    DateDisplay(date: _selectedDate),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightBlue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(constraints.maxWidth * 0.9, 60.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Select date',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(constraints.maxWidth * 0.9, 60.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text('Confirm'),
                      onPressed: () async {
                        if (_quantity < 0) {
                          _quantity = 0;
                        }
                        widget.validity = Validity.withValues(
                          _name,
                          widget.validity.productId,
                          widget.validity.uid,
                          quantity: _quantity,
                          day: _selectedDate.day,
                          month: _selectedDate.month,
                          year: _selectedDate.year,
                        );

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
