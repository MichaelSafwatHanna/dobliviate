import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dobliviate/GalleryInvoker.dart';
import 'package:dobliviate/Image.dart';
import 'package:dobliviate/blocs/images_loader_bloc/bloc.dart';

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
        final List<Image> images = await GalleryPlatformInvoker.getTodayImages;
        yield ImagesLoaded(images: images);
      } catch (_) {
        yield ImagesError();
      }
    }
  }
}
