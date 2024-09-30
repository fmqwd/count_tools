import 'package:count_tools/data/model/activity_data.dart';
import 'package:flutter/material.dart';

class SingleActivityItem extends StatelessWidget {
  final ActivityData data;
  final VoidCallback? onClick;

  const SingleActivityItem({
    Key? key,
    required this.data,
    required this.onClick,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              const SizedBox(height: 10),
              Text(data.date, style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
              const SizedBox(height: 2),
              Text(data.address, style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
            ],
          )));
}
