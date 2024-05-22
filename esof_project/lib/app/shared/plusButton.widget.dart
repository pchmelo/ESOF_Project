import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.35,
      padding: EdgeInsets.all(screenWidth * 0.02),
      color: Colors.transparent,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.02, 0, 0),
              child: Text(
                'Select Your Option',
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
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
                      height: screenHeight * 0.05,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.02, 0, screenWidth * 0.02, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight * 0.022,
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenWidth * 0.2, screenWidth * 0.2),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              iconSize: screenHeight * 0.15,
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
                              width: screenWidth * 0.125,
                            ),
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight * 0.022,
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenWidth * 0.15, screenWidth * 0.15),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              icon:
                                  const Icon(CupertinoIcons.barcode_viewfinder),
                              iconSize: screenHeight * 0.15,
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
