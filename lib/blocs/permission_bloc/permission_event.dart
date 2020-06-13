abstract class PermissionEvent {
  const PermissionEvent();
}

class CheckStoragePermission extends PermissionEvent {}

class RequestStoragePermission extends PermissionEvent {}
