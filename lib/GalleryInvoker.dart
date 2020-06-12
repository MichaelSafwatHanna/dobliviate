import 'package:dobliviate/Image.dart';
import 'package:flutter/services.dart';

class GalleryPlatformInvoker {
  static const _channel = const MethodChannel('dobliviate.dobliviate/gallery');

  static Future<Object> get getTodayImages async {
    Map<dynamic, dynamic> todayImagesMap =
        await _channel.invokeMethod('getTodayImages');
    List<Image> images = List();
    int imagesCount = (todayImagesMap["URI"] as List).length;
    for (int i = 0; i < imagesCount; i++) {
      images.add(Image(
          (todayImagesMap["URI"] as List)[i],
          (todayImagesMap["DISPLAY_NAME"] as List)[i],
          DateTime.parse((todayImagesMap["DATE_ADDED"] as List)[i]),
          (todayImagesMap["TITLE"] as List)[i]));
    }
    return images;
  }
}
