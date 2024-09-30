import 'package:count_tools/data/model/social_media_data.dart';
import 'member_data.dart';

class GroupData {
  late String _id;
  late String _name;
  late String? _avatarUrl;
  late String? _description;
  late String _location;
  late String? _extraInfo;
  late String? _members;
  late String? _socialMedia;

  GroupData({
    required String id,
    required String name,
    required String? avatarUrl,
    required String? description,
    required String location,
    required String? extraInfo,
    required String? members,
    required String? socialMedia,
  }) {
    _id = id;
    _avatarUrl = avatarUrl;
    _name = name;
    _description = description;
    _location = location;
    _extraInfo = extraInfo;
    _members = members;
    _socialMedia = socialMedia;
  }

  GroupData.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _avatarUrl = json['avatar_url'] ?? '';
    _name = json['name'] ?? '';
    _description = json['description'] ?? '';
    _location = json['location'] ?? '';
    _extraInfo = json['extra_info'] ?? '';

    _members = json['members'];

    _socialMedia = json['social_media_list'];
  }

  GroupData copyWith({
    String? id,
    String? avatarUrl,
    String? name,
    String? description,
    String? location,
    String? extraInfo,
    String? members,
    String? socialMedia,
  }) =>
      GroupData(
        id: id ?? _id,
        avatarUrl: avatarUrl ?? _avatarUrl,
        name: name ?? _name,
        description: description ?? _description,
        location: location ?? _location,
        extraInfo: extraInfo ?? _extraInfo,
        members: members ?? _members,
        socialMedia: socialMedia ?? _socialMedia,
      );

  String get id => _id;

  String? get avatarUrl => _avatarUrl;

  String get name => _name;

  String? get description => _description;

  String get location => _location;

  String? get extraInfo => _extraInfo;

  String? get members => _members;

  String? get socialMedia => _socialMedia;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'avatar_url': _avatarUrl,
        'name': _name,
        'description': _description,
        'location': _location,
        'extra_info': _extraInfo,
        'members': _members,
        'social_media_list': _socialMedia,
      };
}
