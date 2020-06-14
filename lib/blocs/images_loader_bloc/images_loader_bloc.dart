import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dobliviate/blocs/images_loader_bloc/bloc.dart';
import 'package:dobliviate/models/ImageInfo.dart';
import 'package:dobliviate/util/GalleryInvoker.dart';

class ImagesLoaderBloc extends Bloc<ImagesLoaderEvent, ImagesLoaderState> {
  @override
  ImagesLoaderState get initialState => ImagesEmpty();

  @override
  Stream<ImagesLoaderState> mapEventToState(
    ImagesLoaderEvent event,
  ) async* {
    if (event is RefreshImages) {
      yield ImagesLoading();
      try {
        final List<ImageInfo> images =
            await GalleryPlatformInvoker.getTodayImages;
        yield ImagesLoaded(images: images);
      } catch (_) {
        yield ImagesError();
      }
    } else if (event is SelectAll) {
      if (state is ImagesLoaded) {
        final List<ImageInfo> selectedImages = (state as ImagesLoaded)
            .images
            .map((image) => image.copyWith(isSelected: true))
            .toList();
        yield ImagesLoaded(images: selectedImages);
      }
    } else if (event is DeSelectAll) {
      final List<ImageInfo> selectedImages = (state as ImagesLoaded)
          .images
          .map((image) => image.copyWith(isSelected: false))
          .toList();
      yield ImagesLoaded(images: selectedImages);
    }
  }
}
