import 'package:dobliviate/models/ImageInfo.dart';
import 'package:flutter/services.dart';

class ImagesRepository {
  static const _channel = const MethodChannel('dobliviate.dobliviate/gallery');
  static const int DAY = 24 * 60 * 60;

  static Future<Object> get({int secondsRange = DAY}) async {
    Map<dynamic, dynamic> todayImagesMap = await _channel
        .invokeMethod('getImages', {"secondsRange": secondsRange});

    List<ImageInfo> images = List();
    int imagesCount = (todayImagesMap["URI"] as List).length;
    for (int i = 0; i < imagesCount; i++) {
      images.add(ImageInfo(
          (todayImagesMap["URI"] as List)[i],
          (todayImagesMap["DISPLAY_NAME"] as List)[i],
          DateTime.parse((todayImagesMap["DATE_ADDED"] as List)[i]),
          (todayImagesMap["TITLE"] as List)[i]));
    }
    return images;
  }

  static Future<void> delete(String uri) async {
    await _channel.invokeMethod('deleteImage', {"uri": uri});
  }
}
