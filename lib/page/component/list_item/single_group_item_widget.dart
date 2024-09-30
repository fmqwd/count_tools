import 'package:cached_network_image/cached_network_image.dart';
import 'package:count_tools/data/model/group_data.dart';
import 'package:flutter/material.dart';

class SingleGroupItem extends StatelessWidget {
  final GroupData data;
  final VoidCallback? onClick;

  const SingleGroupItem({
    Key? key,
    required this.data,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onClick,
      child: Container(
          width: double.infinity,
          height: 100,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333))),
                const SizedBox(height: 10),
                Text(data.description ?? '',
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF666666))),
                const SizedBox(height: 2),
                Text(data.location,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF666666))),
              ],
            ),
            CachedNetworkImage(
                imageUrl: data.avatarUrl ?? '',
                height: 88,
                width: 88,
                fit: BoxFit.cover)
          ])));
}
