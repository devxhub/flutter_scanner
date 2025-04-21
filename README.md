# flutter_scanner_devxhub by DEVxHUB

A plugin for Flutter apps that adds barcode scanning support on both Android and iOS.

## Example

Just clone or download the repository, open the project in `Android Studio/ VS Code`, open `pubspec.yaml` and click on `Packages get`.
Connect device and hit `run`.
To run on iPhone you need to run from Xcode first time and just make `pod install` in `example/ios` then run from Xcode.

## Getting Started

Follow the steps for Android and iOS

PLEASE FOLLOW **iOS** STEPS CAREFULLY

### Android

You need to use `FlutterFragmentActivity` instead of `FlutterActivity` in `MainActivity.kt`

### iOS - Requires Swift support

Deployment target : 12

#### 1. Fresh start:

1.  Create a new flutter project. Please check for **Include swift support for iOS code**.
2.  After creating new flutter project open `/ios` project in Xcode and set minimum **deployment target to 12**
    and set **Swift version to 5**.
3.  After setting up the deployment target and swift version, close the Xcode then run **pod install** in `/ios` in flutter project.

You have done with basic configuration now proceed to section **How to use**.

#### 2. Adding to existing flutter app:

#### If your existing ios code is **Swift** then you just need to do following.

1. Set **minimum deployment target to 12** and set **Swift version to 5**.
2. Close the Xcode and run **pod install** in `/ios` in flutter project.
3. Now proceed to section **How to use**.

#### If your existing ios code is **Objective-C** then you need to do following.

1. Create a new flutter project with same name at different location (Don't forget to check **Include swift support for iOS code** while creating)
2. Just copy newly created `/ios` folder from project and replace with existing `/ios`.
3. Open ios project in Xcode and set **minimum deployment target to 12** and set **Swift version to 5**.
4. Run **pod install** in `/ios`

**Note: If you did any changes in ios part before, you might need to make these configuration again**

## How to use ?

To use on iOS, you will need to add the camera usage description.
To do that open the Xcode and add camera usage description in `Info.plist`.

```
<key>NSCameraUsageDescription</key>
<string>Camera permission is required for barcode scanning.</string>
```

After making the changes in Android ans iOS add flutter_scanner_devxhub to `pubspec.yaml`

```
dependencies:
  ...
  flutter_scanner_devxhub: ^2.0.0
```

1. You need to import the package first.

```
import 'package:flutter_scanner_devxhub/flutter_scanner_devxhub.dart';
```

2. Then use the `scanBarcode` method to access barcode scanning.

```
String barcodeScanRes = await FlutterScanner.scanBarcode(
          lineColor: '#ff6666',
          cancelButtonText: 'Cancel',
          isShowFlashIcon: true,
          scanMode: ScanMode.QR,
          isShowInputIcon: true,
          changeInputIconPath: "assets/input.png" ,
          isOrientationLandscape: true,
          isNeedLengthCondition: true,
          isNeedOnlyDigitCondition: true,
          minimunLengthMinusOne: 10,
          maximunLengthPlusOne: 50,
          iconSize: 50,
          fontSize: 20,
          duration: Duration(seconds: 20),
          flashIconPath: "assets/flash.png",
          flashOffIconPath: "assets/flashoff.png",
          changeCameraIconPath: "assets/camera.png");
```

Here in `scanBarcode`,

`lineColor` is hex-color which is the color of line in barcode overlay you can pass color of your choice,

`cancelButtonText` is a text of cancel button on screen you can pass text of your choice and language,

`isShowFlashIcon` is bool value used to show or hide the flash icon,

`scanMode` is a enum in which user can pass any of `{ QR, BARCODE, DEFAULT }`, if nothing is passed it will consider a default value which will be `QR`.
It shows the graphics overlay like for barcode and QR.

`iconSize` is int value used to change size of flash icon and camera chnage icon,

`fontSize` is float value used to change size of cancel text,

`duration` is Duration type value used to close scanner after that time,

`isShowInputIcon` is extra button for close scanner and return -3,

`changeInputIconPath` is String value used to change the input icon,

`isOrientationLandscape` is bool value used to change the Orientation by force,

`isNeedOnlyDigitCondition` is bool value used to only scan digit,

`isNeedLengthCondition` is bool value used to get data by length condition,

`minimunLengthMinusOne` is int value used to check minimum length value - 1,

`maximunLengthPlusOne` is int value used to check maximum length value + 1,

`flashIconPath` is String value used to change the flash icon,

`flashOffIconPath` is String value used to change the flash off icon,

`changeCameraIconPath` is String value used to change the camera chnage icon,

NOTE: Currently, `scanMode` is just to show the graphics overlay for barcode and QR. Any of this mode selected will scan both QR and barcode and `flashIconPath` , `flashOffIconPath` & `changeCameraIconPath` is the assets image path of futter.

# Screen Shots

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/devxhub/flutter_scanner/second_update/screen_shots/Screenshot_20231224-211848.png" width="200" style="max-width:100%;" /></td>
    <td><img src="https://raw.githubusercontent.com/devxhub/flutter_scanner/second_update/screen_shots/Screenshot_20231224-211932.png" width="200" style="max-width:100%;" /></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/devxhub/flutter_scanner/second_update/screen_shots/Screenshot_20231227-180251.png" width="200" style="max-width:100%;" /></td>
    <td><img src="https://raw.githubusercontent.com/devxhub/flutter_scanner/second_update/screen_shots/Screenshot_20231227-184259.png" width="200" style="max-width:100%;" /></td>
  </tr>
</table>
