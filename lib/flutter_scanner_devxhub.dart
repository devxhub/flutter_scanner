import 'dart:async';

import 'package:flutter/services.dart';

/// Scan mode which is either QR code or BARCODE
enum ScanMode { QR, BARCODE, DEFAULT }

/// Provides access to the barcode scanner.
///
/// This class is an interface between the native Android and iOS classes and a
/// Flutter project.
class FlutterScanner {
  static const MethodChannel _channel =
      MethodChannel('flutter_scanner_devxhub');

  // static const EventChannel _eventChannel =
  //     EventChannel('flutter_scanner_devxhub_receiver');

  // static Stream? _onBarcodeReceiver;

  /// Scan with the camera until a barcode is identified, then return.
  ///
  /// Shows a scan line with [lineColor] over a scan window. A flash icon is
  /// displayed if [isShowFlashIcon] is true. The text of the cancel button can
  /// be customized with the [cancelButtonText] string.
  static Future<String> scanBarcode(
      {String? lineColor,
      String? cancelButtonText,
      bool? isShowFlashIcon,
      bool? isShowInputIcon,
      bool? isOrientationLandscape,
      ScanMode? scanMode,
      int? iconSize,
      Duration? duration,
      double? fontSize,
      String? flashIconPath,
      String? flashOffIconPath,
      String? changeInputIconPath,
      String? changeCameraIconPath}) async {
    // Pass params to the plugin
    Map params = <String, dynamic>{
      'lineColor': lineColor ?? '#ff6666',
      'cancelButtonText': cancelButtonText ?? 'Cancel',
      'isShowFlashIcon': isShowFlashIcon ?? true,
      'isShowInputIcon': isShowInputIcon ?? false,
      'isOrientationLandscape': isOrientationLandscape ?? false,
      'flashIconPath': flashIconPath ?? "",
      'flashOffIconPath': flashOffIconPath ?? "",
      'changeCameraIconPath': changeCameraIconPath ?? "",
      'changeInputIconPath': changeInputIconPath ?? "",
      'isContinuousScan': false,
      'scanMode': scanMode?.index ?? 0,
      'iconSize': iconSize?.toString() ?? "0",
      'fontSize': fontSize?.toString() ?? "0",
      'duration': duration?.inMilliseconds.toString() ?? "0",
    };

    print(params);

    // / Get barcode scan result
    final barcodeResult =
        await _channel.invokeMethod('scanBarcode', params) ?? '';
    return barcodeResult;
  }

  static Future<String> closeScanner() async {
    final barcodeResult = await _channel.invokeMethod('closeScanner') ?? '';
    return barcodeResult;
  }

  // / Returns a continuous stream of barcode scans until the user cancels the
  // / operation.
  // /
  // / Shows a scan line with [lineColor] over a scan window. A flash icon is
  // / displayed if [isShowFlashIcon] is true. The text of the cancel button can
  // / be customized with the [cancelButtonText] string. Returns a stream of
  // / detected barcode strings.
  // static Stream? getBarcodeStreamReceiver(String lineColor,
  //     String cancelButtonText, bool isShowFlashIcon, ScanMode scanMode) {
  //   if (cancelButtonText.isEmpty) {
  //     cancelButtonText = 'Cancel';
  //   }

  //   // Pass params to the plugin
  //   Map params = <String, dynamic>{
  //     'lineColor': lineColor,
  //     'cancelButtonText': cancelButtonText,
  //     'isShowFlashIcon': isShowFlashIcon,
  //     'isContinuousScan': true,
  //     'scanMode': scanMode.index
  //   };

  //   // Invoke method to open camera, and then create an event channel which will
  //   // return a stream
  //   _channel.invokeMethod('scanBarcode', params);
  //   _onBarcodeReceiver ??= _eventChannel.receiveBroadcastStream();
  //   return _onBarcodeReceiver;
  // }
}
