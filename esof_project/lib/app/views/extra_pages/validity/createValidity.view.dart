import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:flutter/material.dart';
import '../../../models/product.model.dart';

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

class CreateValidity extends StatefulWidget {
  final Product product;
  final int quantity;
  const CreateValidity(
      {super.key, required this.product, required this.quantity});

  @override
  State<CreateValidity> createState() => _CreateValidityState();
}

class _CreateValidityState extends State<CreateValidity> {
  final _formKey = GlobalKey<FormState>();
  Function controller = ValidityController().CreateValidity;
  String _name = '';
  DateTime _selectedDate = DateTime.now();

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
    _name = widget.product.name;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            'Add an Expiration Date to ${widget.product.name}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.product.name,
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
                const Padding(padding: EdgeInsets.only(top: 20)),
                DateDisplay(date: _selectedDate),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(screenWidth * 0.9, 60.0),
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
                      Size(screenWidth * 0.9, 60.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    await ValidityController().CreateValidity(
                        widget.product.id,
                        widget.quantity,
                        _selectedDate.day,
                        _selectedDate.month,
                        _selectedDate.year,
                        _name);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
