import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF2F3F5),
        appBar: AppBar(title: const Text('设置')),
        body: Center(child: _buildContent(context)),
      );

  Widget _buildContent(BuildContext context) => Column(children: [
        const SizedBox(height: 12),
        _buildPersonInfo(),
        const SizedBox(height: 4),
      ]);

  Widget _buildPersonInfo() => GestureDetector(
      child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 9),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(children: [
            const Text('个人信息', style: AppTextStyle.bodyBig),
            Expanded(child: Container()),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16)
          ])));
}
