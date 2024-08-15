import 'package:flutter/material.dart';

void showUserInfoDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('笑死，你不会真的觉得这个app有什么个人信息可以设置吧？'),
        actions: [
          TextButton(
            child: const Text('ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
