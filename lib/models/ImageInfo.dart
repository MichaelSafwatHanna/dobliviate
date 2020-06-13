class ImageInfo {
  String _uri;
  String _displayName;
  DateTime _dateAdded;
  String _title;

  ImageInfo(this._uri, this._displayName, this._dateAdded, this._title);

  String get title => _title;

  DateTime get dateAdded => _dateAdded;

  String get displayName => _displayName;

  String get uri => _uri;
}
