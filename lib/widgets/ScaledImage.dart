import 'dart:io';

import 'package:flutter/material.dart';

class ScaledImage extends StatelessWidget {
  final String imageUri;

  const ScaledImage({Key key, @required this.imageUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUri,
      child: Material(
        color: Colors.black,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.file(
            File(imageUri),
            fit: BoxFit.contain,
            cacheWidth: 512,
          ),
        ),
      ),
    );
  }
}
