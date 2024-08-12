class ProjectData {
  late String _id;  // 项目id
  late String _title; // 项目标题
  late String _subTitle;  // 项目副标题
  late String _count;  // 项目数量
  late String _ext;  // 项目扩展

  ProjectData({
    required String id,
    required String title,
    required String subTitle,
    required String count,
    required String ext,
  }) {
    _id = id;
    _title = title;
    _subTitle = subTitle;
    _count = count;
    _ext = ext;
  }

  ProjectData.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _title = json['title'] ?? '';
    _subTitle = json['subTitle'] ?? '';
    _count = json['count'] ?? '';
    _ext = json['ext'];
  }

  ProjectData copyWith({
    String? id,
    String? title,
    String? subTitle,
    String? count,
    String? ext,
  }) =>
      ProjectData(
        id: id ?? _id,
        title: title ?? _title,
        subTitle: subTitle ?? _subTitle,
        count: count ?? _count,
        ext: ext ?? _ext,
      );

  String get id => _id;

  String get title => _title;

  String get subTitle => _subTitle;

  String get count => _count;

  String get ext => _ext;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['subTitle'] = _subTitle;
    map['count'] = _count;
    map['ext'] = _ext;
    return map;
  }
}
