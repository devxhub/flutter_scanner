#import "FlutterBarcodeScannerPlugin.h"
#import <flutter_barcode_scanner_devxhub/flutter_barcode_scanner_devxhub-Swift.h>

@implementation FlutterBarcodeScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBarcodeScannerPlugin registerWithRegistrar:registrar];
}
@end
