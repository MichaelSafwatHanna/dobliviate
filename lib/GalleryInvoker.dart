import 'package:flutter/services.dart';

class GalleryPlatformInvoker {
  static const _channel = const MethodChannel('dobliviate.dobliviate/gallery');

  static Future<Object> get getTodayImages async {
    Map<dynamic, dynamic> todayImagesMap =
        await _channel.invokeMethod('getTodayImages');
    return todayImagesMap;
  }
}
