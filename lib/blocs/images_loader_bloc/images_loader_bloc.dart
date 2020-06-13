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
    }
  }
}
