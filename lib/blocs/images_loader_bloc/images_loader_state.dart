import 'package:dobliviate/models/ImageInfo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ImagesLoaderState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImagesEmpty extends ImagesLoaderState {}

class ImagesLoading extends ImagesLoaderState {}

class ImagesLoaded extends ImagesLoaderState {
  final List<ImageInfo> images;

  ImagesLoaded({@required this.images}) : assert(images != null);

  @override
  List<Object> get props => [images];
}

class ImagesError extends ImagesLoaderState {}
