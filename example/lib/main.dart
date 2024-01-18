import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scanner/flutter_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Future<void> startBarcodeScanStream() async {
  //   FlutterScanner.getBarcodeStreamReceiver(
  //           '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
  //       .listen((barcode) => print(barcode));
  // }

  Future<void> scanQR() async {
    // String barcodeScanRes;
    // try {
    //   barcodeScanRes = await FlutterScanner.scanBarcode(
    //       '#ff6666',
    //       'Cancel',
    //       true,
    //       ScanMode.QR,
    //       50,
    //       20,
    //       "assets/flash.png",
    //       "assets/flashoff.png",
    //       "assets/camera.png");
    //   print(barcodeScanRes);
    // } on PlatformException {
    //   barcodeScanRes = 'Failed to get platform version.';
    // }
    // if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  Future<void> scanQR2() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterScanner.scanBarcode();
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    // String barcodeScanRes;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   barcodeScanRes = await FlutterScanner.scanBarcode(
    //       '#ff6666',
    //       'Cancel',
    //       isShowFlashIcon: true,
    //       scanMode: ScanMode.BARCODE,
    //       iconSize: 50,
    //       20,
    //       "assets/flashoff.png",
    //       "assets/flash.png",
    //       "assets/camera.png");
    //   print(barcodeScanRes);
    // } on PlatformException {
    //   barcodeScanRes = 'Failed to get platform version.';
    // }

    // if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Start barcode scan')),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('Start QR scan')),
                        ElevatedButton(
                            onPressed: () => scanQR2(),
                            child: Text('Start QR scan 2')),
                        // ElevatedButton(
                        //     onPressed: () => startBarcodeScanStream(),
                        //     child: Text('Start barcode scan stream')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20)),
                        Image.asset(
                          "assets/flash.png",
                          width: 20,
                          height: 20,
                        )
                      ]));
            })));
  }
}
