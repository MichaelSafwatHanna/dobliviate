class ImageInfo {
  String _uri;
  String _displayName;
  DateTime _dateAdded;
  String _title;
  bool isSelected;

  ImageInfo(this._uri, this._displayName, this._dateAdded, this._title,
      {this.isSelected = false});

  String get title => _title;

  DateTime get dateAdded => _dateAdded;

  String get displayName => _displayName;

  String get uri => _uri;

  ImageInfo copyWith(
      {String uri,
      String displayName,
      DateTime dateAdded,
      String title,
      bool isSelected}) {
    return ImageInfo(uri ?? this._uri, displayName ?? this._displayName,
        dateAdded ?? this._dateAdded, title ?? this._title,
        isSelected: isSelected ?? this.isSelected);
  }
}
