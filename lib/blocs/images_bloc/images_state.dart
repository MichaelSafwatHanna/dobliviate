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

  ImagesLoadSuccess({@required this.images}) : assert(images != null);

  @override
  List<Object> get props => [images];
}

class ImagesLoadFailure extends ImagesState {}
