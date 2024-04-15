import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'barCodeProcess.dart';

class BarScannerView extends StatefulWidget {
  const BarScannerView({super.key});

  @override
  State<BarScannerView> createState() => _BarScannerView();
}

class _BarScannerView extends State<BarScannerView> {
  readCodeBar() async {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bar Code Scanner'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: readCodeBar,
                child: const Icon(Icons.barcode_reader),
              )
            ],
          ),
        ));
  }
}
