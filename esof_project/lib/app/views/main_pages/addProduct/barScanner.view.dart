import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarScannerView extends StatefulWidget {
  @override
  State<BarScannerView> createState() => _BarScannerView();
}

class _BarScannerView extends State<BarScannerView> {
  String ticket = "";

  readCodeBar() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000', "Cancelar", false, ScanMode.BARCODE);
    setState(() => ticket = code != '-1' ? code : '');
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
              if (ticket != '')
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    'Ticket: $ticket',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ElevatedButton(
                onPressed: readCodeBar,
                child: const Icon(Icons.barcode_reader),
              )
            ],
          ),
        ));
  }
}
