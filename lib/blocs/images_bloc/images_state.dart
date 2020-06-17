import 'package:dobliviate/models/ImageInfo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ImagesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImagesEmpty extends ImagesState {}

class ImagesLoadInProgress extends ImagesState {}

class ImagesLoadSuccess extends ImagesState {
  final List<ImageInfo> images;
  final int selected;

  ImagesLoadSuccess({@required this.images, @required this.selected})
      : assert(images != null && selected != null);

  @override
  List<Object> get props => [images, selected];
}

class ImagesLoadFailure extends ImagesState {}
