import 'dart:io';

import 'package:dobliviate/blocs/images_bloc/bloc.dart';
import 'package:dobliviate/models/ImageInfo.dart' as dobliviate;
import 'package:dobliviate/widgets/ScaledImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

                      if (widget.images[index].isSelected) {
                        BlocProvider.of<ImagesBloc>(context).add(SelectImage());
                      } else {
                        BlocProvider.of<ImagesBloc>(context)
                            .add(DeselectImage());
                      }
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
                        AnimatedContainer(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.images[index].isSelected
                                  ? Colors.white
                                  : Colors.black,
                              width: widget.images[index].isSelected ? 8 : 0,
                            ),
                          ),
                          duration: const Duration(milliseconds: 256),
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
                                ? Colors.white
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
