public class YourPlugin: NSObject, FlutterPlugin {
  var registrar: FlutterPluginRegistrar? = nil

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = YourPlugin()
    instance.registrar = registrar
  }

  func loadImage() {
    let key = registrar?.lookupKey(forAsset: "assets/images/your_image.png")
    let imagePath = Bundle.main.path(forResource: key, ofType: nil)!
    let image: UIImage = UIImage(contentsOfFile: imagePath)!
    // Now you can use this image in your UIButton
  }
}