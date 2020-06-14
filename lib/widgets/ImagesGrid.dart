import 'dart:io';

import 'package:dobliviate/models/ImageInfo.dart' as dobliviate;
import 'package:dobliviate/widgets/ScaledImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagesGrid extends StatefulWidget {
  final List<dobliviate.ImageInfo> images;

  const ImagesGrid({Key key, @required this.images}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImagesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: List<Widget>.generate(
          widget.images.length,
          (int index) => Hero(
                tag: widget.images[index].uri,
                child: Material(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.images[index].isSelected =
                            !widget.images[index].isSelected;
                      });
                    },
                    onLongPress: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return ScaledImage(imageUri: widget.images[index].uri);
                      }));
                    },
                    child: Stack(
                      fit: StackFit.passthrough,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: widget.images[index].isSelected ? 8 : 0,
                            ),
                          ),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 256),
                            opacity: widget.images[index].isSelected ? 0.5 : 1,
                            child: Image.file(
                              File(widget.images[index].uri),
                              fit: BoxFit.cover,
                              cacheWidth: 512,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.clear,
                            size: 36,
                            color: widget.images[index].isSelected
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
