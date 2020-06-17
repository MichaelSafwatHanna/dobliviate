import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dobliviate/blocs/images_bloc/bloc.dart';
import 'package:dobliviate/models/ImageInfo.dart';
import 'package:dobliviate/repositories/ImagesRepository.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  @override
  ImagesState get initialState => ImagesEmpty();

  @override
  Stream<ImagesState> mapEventToState(
    ImagesEvent event,
  ) async* {
    if (event is RefreshImages) {
      yield* _mapRefreshImagesToState();
    } else if (event is SelectAllImages) {
      yield* _mapSelectAllImagesToState(state);
    } else if (event is DeselectAllImages) {
      yield* _mapDeSelectAllImagesToState(state);
    } else if (event is DeleteImages) {
      yield* _mapDeleteImagesToState(state);
    }
  }

  Stream<ImagesState> _mapRefreshImagesToState() async* {
    yield ImagesLoadInProgress();
    try {
      final List<ImageInfo> images = await ImagesRepository.get();
      yield ImagesLoadSuccess(images: images);
    } catch (_) {
      yield ImagesLoadFailure();
    }
  }

  Stream<ImagesState> _mapSelectAllImagesToState(ImagesState state) async* {
    if (state is ImagesLoadSuccess) {
      final List<ImageInfo> selectedImages = state.images
          .map((image) => image.copyWith(isSelected: true))
          .toList();
      yield ImagesLoadSuccess(images: selectedImages);
    }
  }

  Stream<ImagesState> _mapDeSelectAllImagesToState(ImagesState state) async* {
    if (state is ImagesLoadSuccess) {
      final List<ImageInfo> selectedImages = state.images
          .map((image) => image.copyWith(isSelected: false))
          .toList();
      yield ImagesLoadSuccess(images: selectedImages);
    }
  }

  Stream<ImagesState> _mapDeleteImagesToState(ImagesState state) async* {
    if (state is ImagesLoadSuccess) {
      yield ImagesLoadInProgress();
      final List<ImageInfo> delete =
          state.images.where((image) => image.isSelected).toList();
      delete.forEach((element) async {
        await ImagesRepository.delete(element.uri);
      });
      yield ImagesLoadSuccess(
          images: state.images.where((image) => !image.isSelected).toList());
    }
  }
}
