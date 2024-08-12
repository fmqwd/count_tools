class ItemData {
  late String _id;  // 项目id
  late String _price;  // 项目价格
  late String _eventName;  // 活动名称
  late String _type;  // 项目类型
  late String _date;  // 项目日期
  late String _itemName;  // 项目名称
  late String _parentId;  // 项目父id
  late String _ext;  // 项目扩展

  ItemData({
    required String id,
    required String price,
    required String eventName,
    required String date,
    required String itemName,
    required String type,
    required String parentId,
    required String ext
  }) {
    _id = id;
    _price = price;
    _eventName = eventName;
    _date = date;
    _itemName = itemName;
    _type = type;
    _parentId = parentId;
    _ext = ext;
  }

  ItemData.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _price = json['price'];
    _eventName = json['eventName'] ?? '';
    _type = json['type'];
    _date = json['date'] ?? '';
    _itemName = json['itemName'] ?? '';
    _parentId = json['parentId'] ?? '';
    _ext = json['ext'] ?? '';
  }

  ItemData copyWith({
    String? id,
    String? price,
    String? eventName,
    String? type,
    String? date,
    String? itemName,
    String? parentId,
    String? ext
  }) =>
      ItemData(
          id: id ?? _id,
          price: price ?? _price,
          eventName: eventName ?? _eventName,
          type: type ?? _type,
          date: date ?? _date,
          itemName: itemName ?? _itemName,
          parentId: parentId ?? _parentId,
          ext: ext ?? _ext
      );

  String get id => _id;

  String get price => _price;

  String get eventName => _eventName;

  String get type => _type;

  String get date => _date;

  String get itemName => _itemName;

  String get parentId => _parentId;

  String get ext => _ext;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['eventName'] = _eventName;
    map['type'] = _type;
    map['date'] = _date;
    map['itemName'] = _itemName;
    map['parentId'] = _parentId;
    map['ext'] = _ext;
    return map;
  }
}
