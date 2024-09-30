class TagData {
  late String _id;
  late String _textColor;
  late String _backgroundColor;
  late String _text;
  late String _extraInfo;

  TagData({
    required id,
    required textColor,
    required backgroundColor,
    required text,
    required extraInfo,
  }) {
    _id = id;
    _textColor = textColor;
    _backgroundColor = backgroundColor;
    _text = text;
    _extraInfo = extraInfo;
  }

  TagData.fromJson(dynamic json) {
    _id = json['id'];
    _textColor = json['text_color'];
    _backgroundColor = json['background_color'];
    _text = json['text'];
    _extraInfo = json['extra_info'];
  }

  TagData copyWith({
    String? id,
    String? textColor,
    String? backgroundColor,
    String? text,
    String? extraInfo,
  }) =>
      TagData(
        id: id ?? _id,
        textColor: textColor ?? _textColor,
        backgroundColor: backgroundColor ?? _backgroundColor,
        text: text ?? _text,
        extraInfo: extraInfo ?? _extraInfo,
      );

  String get id => _id;

  String get textColor => _textColor;

  String get backgroundColor => _backgroundColor;

  String get text => _text;

  String get extraInfo => _extraInfo;

  Map<String, dynamic> toJson()=> {
    "id": _id,
    "text_color": _textColor,
    "background_color": _backgroundColor,
    "text": _text,
    "extra_info": _extraInfo
  };

}
