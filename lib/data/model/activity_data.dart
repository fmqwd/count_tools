class ActivityData {
  late String _id; //活动ID
  late String _name; //活动名
  late String _desc; //活动描述
  late String _date; //活动日期
  late String _time; //活动时间
  late String _address; //活动地点
  late String _price; //活动价格
  late String _chikaNum; //切数
  late String _peopleNum; //人数
  late String _ext; //拓展

  ActivityData({
    required id,
    required name,
    required desc,
    required date,
    required time,
    required address,
    required price,
    required chikaNum,
    required peopleNum,
    required ext,
  }) {
    _id = id;
    _name = name;
    _desc = desc;
    _date = date;
    _time = time;
    _address = address;
    _price = price;
    _chikaNum = chikaNum;
    _peopleNum = peopleNum;
    _ext = ext;
  }

  ActivityData.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['name'];
    _desc = json['desc'];
    _date = json['date'];
    _time = json['time'];
    _address = json['address'];
    _price = json['price'];
    _chikaNum = json['chikaNum'];
    _peopleNum = json['peopleNum'];
    _ext = json['ext'];
  }

  ActivityData copyWith({
    String? id,
    String? name,
    String? desc,
    String? date,
    String? time,
    String? address,
    String? price,
    String? chikaNum,
    String? peopleNum,
    String? ext,
  }) =>
      ActivityData(
        id: id ?? _id,
        name: name ?? _name,
        desc: desc ?? _desc,
        date: date ?? _date,
        time: time ?? _time,
        address: address ?? _address,
        price: price ?? _price,
        chikaNum: chikaNum ?? _chikaNum,
        peopleNum: peopleNum ?? _peopleNum,
        ext: ext ?? _ext,
      );

  String get id => _id;

  String get name => _name;

  String get desc => _desc;

  String get date => _date;

  String get time => _time;

  String get address => _address;

  String get price => _price;

  String get chikaNum => _chikaNum;

  String get peopleNum => _peopleNum;

  String get ext => _ext;

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'name': _name,
        'desc': _desc,
        'date': _date,
        'time': _time,
        'address': _address,
        'price': _price,
        'chikaNum': _chikaNum,
        'peopleNum': _peopleNum,
        'ext': _ext,
      };
}
