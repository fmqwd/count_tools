import 'package:count_tools/data/model/social_media_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaList extends StatelessWidget {
  final List<SocialMediaData> data;
  final Axis direction;
  final bool showText;

  const SocialMediaList({
    Key? key,
    required this.data,
    this.direction = Axis.horizontal,
    this.showText = true,
  }) : super(key: key);

  Icon _getIcon(String type) {
    switch (type.toLowerCase()) {
      case 'facebook':
        return const Icon(FontAwesomeIcons.facebook, color: Color(0xff3b5998));
      case 'instagram':
        return const Icon(FontAwesomeIcons.instagram, color: Color(0xffe52d27));
      case 'twitter':
        return const Icon(FontAwesomeIcons.twitter, color: Color(0xff1da1f2));
      case 'linkedin':
        return const Icon(FontAwesomeIcons.linkedin, color: Color(0xff0a66c2));
      case 'weibo':
        return const Icon(FontAwesomeIcons.weibo, color: Color(0xffe6162d));
      case 'youtube':
        return const Icon(FontAwesomeIcons.youtube, color: Color(0xffc4302b));
      case 'tiktok':
        return const Icon(FontAwesomeIcons.tiktok, color: Color(0xff1da1f2));
      case 'telegram':
        return const Icon(FontAwesomeIcons.telegram, color: Color(0xff259bcb));
      case 'whatsapp':
        return const Icon(FontAwesomeIcons.whatsapp, color: Color(0xff25d366));
      case 'wechat':
        return const Icon(FontAwesomeIcons.weixin, color: Color(0xff7bb32e));
      case 'qq':
        return const Icon(FontAwesomeIcons.qq, color: Color(0xff1da1f2));
      default:
        return const Icon(FontAwesomeIcons.link, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data
              .map((item) => Row(mainAxisSize: MainAxisSize.min, children: [
                    _getIcon(item.type),
                    if (showText)
                      Text(direction == Axis.horizontal ? item.name : item.type,
                          style: const TextStyle(fontSize: 16))
                  ]))
              .toList()));
}
