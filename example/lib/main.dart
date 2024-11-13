import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scanner_devxhub/flutter_scanner_devxhub.dart';

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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterScanner.scanBarcode(
          lineColor: '#ff6666',
          cancelButtonText: 'Cancel',
          isShowFlashIcon: true,
          scanMode: ScanMode.BARCODE,
          iconSize: 50,
          fontSize: 20,
          flashOffIconPath: "assets/flashoff.png",
          flashIconPath: "assets/flash.png",
          duration: Duration(seconds: 20),
          changeCameraIconPath: "assets/camera.png");
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterScanner.scanBarcode(
          lineColor: '#ff6666',
          cancelButtonText: 'Cancel',
          isShowFlashIcon: true,
          scanMode: ScanMode.QR,
          isShowInputIcon: true,
          isNeedLengthCondition: true,
          isNeedOnlyDigitCondition: true,
          minimunLengthMinusOne: 1,
          maximunLengthPlusOne: 5,
          iconSize: 50,
          fontSize: 20,
          flashOffIconPath: "assets/flashoff.png",
          flashIconPath: "assets/flash.png",
          changeCameraIconPath: "assets/camera.png");
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterScanner.scanBarcode(
          lineColor: '#ff6666',
          cancelButtonText: 'Cancel',
          isShowFlashIcon: true,
          isOrientationLandscape: true,
          isShowInputIcon: true,
          scanMode: ScanMode.BARCODE,
          iconSize: 50,
          fontSize: 20,
          flashOffIconPath: "assets/flashoff.png",
          flashIconPath: "assets/flash.png",
          changeCameraIconPath: "assets/camera.png");
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanQrDefault() async {
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
                            child: Text('start scan with duration')),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('Start QR scan with Condition')),
                        ElevatedButton(
                            onPressed: () => scanBarcode(),
                            child: Text('Start Barcode scan')),
                        ElevatedButton(
                            onPressed: () => scanQrDefault(),
                            child: Text('Start QR scan default')),
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
