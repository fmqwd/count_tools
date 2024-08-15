import 'package:count_tools/utils/route_utils.dart';
import 'package:count_tools/value/url.dart';
import 'package:flutter/material.dart';

void showAppAboutDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text('关于'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('本项目为ota自娱自乐项目，仅供学习交流使用'),
              const Text('理论上可能会没事闲的更新，但是实际上……看心情'),
              const Text('本项目已完整开源至GitHub，欢迎Star和Fork'),
              GestureDetector(
                child: const Text('仓库：fmqwd/count_tools',
                    style: TextStyle(color: Colors.blue)),
                onTap: () async => await RouteUtils.launchURL(AppUrl.gitHub),
              ),
              const Text('Copyright © 2024 by fmqwd'),
            ])));
