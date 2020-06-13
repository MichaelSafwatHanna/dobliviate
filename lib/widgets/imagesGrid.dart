import 'dart:io';

import 'package:dobliviate/models/ImageInfo.dart' as dobliviate;
import 'package:flutter/widgets.dart';

class ImagesGrid extends StatelessWidget {
  final List<dobliviate.ImageInfo> images;

  const ImagesGrid({Key key, @required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List<Container>.generate(
            images.length,
            (int index) => Container(
                    child: Image.file(
                  File(images[index].uri),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ))));
  }
}
