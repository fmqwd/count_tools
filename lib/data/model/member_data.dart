import 'package:count_tools/data/model/social_media_data.dart';

class MemberData {
  late String _id;
  late String _avatarId;
  late String _name;
  late String _location;
  late String _birthday;
  late String _gender;
  late String _description;
  late SocialMediaData _socialMedia;
  late String _extraInfo;

  MemberData({
    required id,
    required avatarId,
    required name,
    required location,
    required birthday,
    required gender,
    required description,
    required socialMedia,
    required extraInfo,
  }) {
    _id = id;
    _avatarId = avatarId;
    _name = name;
    _location = location;
    _birthday = birthday;
    _gender = gender;
    _description = description;
    _socialMedia = socialMedia;
    _extraInfo = extraInfo;
  }

  MemberData.fromJson(dynamic json) {
    _id = json['id'];
    _avatarId = json['avatar_id'];
    _name = json['name'];
    _location = json['location'];
    _birthday = json['birthday'];
    _gender = json['gender'];
    _description = json['description'];
    _socialMedia = SocialMediaData.fromJson(json['social_media']);
    _extraInfo = json['extra_info'];
  }

  MemberData copyWith({
    String? id,
    String? avatarId,
    String? name,
    String? location,
    String? birthday,
    String? gender,
    String? description,
    SocialMediaData? socialMedia,
    String? extraInfo,
  }) =>
      MemberData(
        id: id ?? _id,
        avatarId: avatarId ?? _avatarId,
        name: name ?? _name,
        location: location ?? _location,
        birthday: birthday ?? _birthday,
        gender: gender ?? _gender,
        description: description ?? _description,
        socialMedia: socialMedia ?? _socialMedia,
        extraInfo: extraInfo ?? _extraInfo,
      );

  String get id => _id;

  String get avatarId => _avatarId;

  String get name => _name;

  String get location => _location;

  String get birthday => _birthday;

  String get gender => _gender;

  String get description => _description;

  String get extraInfo => _extraInfo;

  SocialMediaData get socialMedia => _socialMedia;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['avatar_id'] = _avatarId;
    map['name'] = _name;
    map['location'] = _location;
    map['birthday'] = _birthday;
    map['gender'] = _gender;
    map['description'] = _description;
    map['social_media_list'] = _socialMedia.toJson();
    map['extra_info'] = _extraInfo;
    return map;
  }
}
