import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dobliviate/blocs/permission_bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionStatus> {
  @override
  PermissionStatus get initialState => PermissionStatus.undetermined;

  @override
  Stream<PermissionStatus> mapEventToState(
    PermissionEvent event,
  ) async* {
    if (event is CheckStoragePermission) {
      yield await Permission.storage.status;
    } else if (event is RequestStoragePermission) {
      yield await Permission.storage.request();
    }
  }
}
