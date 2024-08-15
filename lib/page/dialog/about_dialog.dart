import 'package:flutter/material.dart';

void showUserInfoDialog(BuildContext context) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('关于'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('本项目为ota自娱自乐项目，仅供学习交流使用'),
        const Text('Copyright © 2024 by fmqwd'),
        GestureDetector(          child: const Text('https://github.com/fmqwd/ota_self_entertainment'),
          onTap: () => launch('https://github.com/fmqwd/ota_self_entertainment'),
        ),
      ],
    ),
    actions: [
      TextButton(
        child: const Text('ok'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  ),
);
