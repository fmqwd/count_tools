class SubProjectData {
  late String _id; // 子项目id
  late String _name; // 子项目名称
  late String _count; // 子项目数量
  late String _countPre; // 子项目数量百分比
  late String _color; // 子项目颜色
  late String _textColor; // 子项目文字颜色
  late String _parentId; // 父项目id
  late String _ext; // 扩展字段

  SubProjectData({
    required String id,
    required String name,
    required String count,
    required String countPre,
    required String color,
    required String textColor,
    required String parentId,
    required String ext,
  }) {
    _id = id;
    _name = name;
    _count = count;
    _countPre = countPre;
    _color = color;
    _textColor = textColor;
    _parentId = parentId;
    _ext = ext;
  }

  SubProjectData.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _name = json['name'];
    _count = json['count'].toString();
    _countPre = json['countPre'];
    _color = json['color'];
    _textColor = json['textColor'];
    _parentId = json['parentId'];
    _ext = json['ext'];
  }

  SubProjectData copyWith({
    String? id,
    String? name,
    String? count,
    String? countPre,
    String? color,
    String? textColor,
    String? parentId,
    String? ext,
  }) =>
      SubProjectData(
        id: _id,
        name: name ?? _name,
        count: count ?? _count,
        countPre: countPre ?? _countPre,
        color: _color,
        textColor: _textColor,
        parentId: _parentId,
        ext: _ext,
      );

  String get id => _id;

  String get name => _name;

  String get count => _count;

  String get countPre => _countPre;

  String get color => _color;

  String get textColor => _textColor;

  String get parentId => _parentId;

  String get ext => _ext;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['count'] = _count;
    map['countPre'] = _countPre;
    map['color'] = _color;
    map['textColor'] = _textColor;
    map['parentId'] = _parentId;
    map['ext'] = _ext;
    return map;
  }
}
