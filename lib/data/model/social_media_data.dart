class SocialMediaData {
  late String _url;
  late String _name;
  late String _type;

  SocialMediaData({
    required url,
    required name,
    required type,
  }) {
    _url = url;
    _name = name;
    _type = type;
  }

  SocialMediaData.fromJson(Map<String, dynamic> json) {
    _url = json['social_media_url'];
    _name = json['social_media_name'];
    _type = json['social_media_type'];
  }

  Map<String, dynamic> toJson() => {
        'social_media_url': _url,
        'social_media_name': _name,
        'social_media_type': _type
      };

  String get url => _url;

  String get name => _name;

  String get type => _type;

  SocialMediaData copyWith({
    String? url,
    String? name,
    String? type,
  }) =>
      SocialMediaData(
          url: url ?? this.url,
          name: name ?? this.name,
          type: type ?? this.type);
}
