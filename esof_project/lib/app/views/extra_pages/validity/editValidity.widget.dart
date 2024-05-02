import 'package:esof_project/app/models/validity.model.dart';
import 'package:flutter/material.dart';

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
  DateTime _selectedDate = DateTime.now(); // Placeholder value

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
    super.initState();
    _selectedDate = DateTime(
      widget.validity.year,
      widget.validity.month,
      widget.validity.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 425,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            'Add a Expiration Date to ${widget.validity.name}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20), // Adjust as needed for spacing

          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.validity.name,
                  decoration: const InputDecoration(
                    labelText: 'Expiration Date Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty
                      ? 'Enter a name to the expiration date'
                      : null,
                  onChanged: (val) => setState(() => _name = val),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                DateDisplay(date: _selectedDate),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.greenAccent),
                  ),
                  child: const Text(
                    'Select date',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150.0, 50.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Decreasing border radius
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    widget.validity = Validity.withValues(
                      _name,
                      widget.validity.productId,
                      widget.validity.uid,
                      quantity: widget.validity.quantity,
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
    ;
  }
}
