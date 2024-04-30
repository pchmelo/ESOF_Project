import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../main.dart';
import '../views/main_pages/addProduct/barCodeProcess.dart';

class PlusButton extends StatefulWidget {
  final Function controller;
  const PlusButton({super.key, required this.controller});

  @override
  State<PlusButton> createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  final _formKey = GlobalKey<FormState>();

  void readCodeBar() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000', "Cancel", false, ScanMode.BARCODE);

    if (code != '-1' && isValidBarcode(code)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BarCodeProcess(barCode: code),
          ),
        );
      });
    }
  }

  bool isValidBarcode(String barcode) {
    final regex = RegExp(r'^\d+$');
    return regex.hasMatch(barcode) && barcode.length == 13;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 325,
      padding: const EdgeInsets.all(15.0),
      color: Colors.transparent,
      child: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
              child: Text(
                'Select Your Option',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(150.0, 150.0),
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0), // Decreasing border radius
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                            iconSize: 80,
                            onPressed: () {
                              String? currentRoute =
                                  ModalRoute.of(context)!.settings.name;
                              if (currentRoute != '/start/add_product') {
                                Navigator.pushReplacementNamed(context,
                                    '/start/add_product/manual_add_product');
                              }
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(150.0, 150.0),
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0), // Decreasing border radius
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.qr_code_scanner_outlined),
                            iconSize: 80,
                            onPressed: () {
                              String? currentRoute =
                                  ModalRoute.of(context)!.settings.name;
                              if (currentRoute != '/start/add_product') {
                                return readCodeBar();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
