import 'package:count_tools/value/style/text_style.dart';
import 'package:flutter/material.dart';

//单个首页list的item
class SingleSubProjectWidget extends StatelessWidget {
  final double width; //宽度
  final String countPercent; //百分比
  final String countNum; //数量
  final String name; //名称
  final Color color; //颜色
  final Color textColor; //文字颜色
  final String index; //序号
  final String showMode; //展示类型
  final void Function() onClick;
  final void Function() onLongClick;

  const SingleSubProjectWidget({
    super.key,
    required this.width,
    required this.countPercent,
    required this.countNum,
    required this.name,
    required this.color,
    required this.textColor,
    required this.index,
    required this.showMode,
    required this.onClick,
    required this.onLongClick,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onClick(),
        onLongPress: () => onLongClick(),
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (Widget widget in _getWidget()) widget,
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: width / 4.5,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(name,
                    style: AppTextStyle.customStyle(
                        size: width / 6.5,
                        color: textColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  List<Widget> _getWidget() {
    switch (showMode) {
      case '仅排名':
        return _onlyIndex();
      case '仅百分比':
        return _onlyPercent();
      case '仅数量':
        return _onlyNum();
      case '数量-百分比':
        return _numPercent();
      case '排名-百分比':
        return _rankPercent();
      case '排名-数量':
        return _rankNum();
      default:
        return _numPercent();
    }
  }

  // 仅排名
  List<Widget> _onlyIndex() => [
        Expanded(child: Container()),
        Text(index, style: AppTextStyle.customSize(width / 3.5)),
        const Text("名"),
        Expanded(child: Container())
      ];

  // 仅百分比
  List<Widget> _onlyPercent() => [
        Expanded(child: Container()),
        const Text("占比"),
        Text(countPercent, style: AppTextStyle.customSize(width / 4.5)),
        Expanded(child: Container())
      ];

  // 仅数量
  List<Widget> _onlyNum() => [
        Expanded(child: Container()),
        Text(countNum, style: AppTextStyle.customSize(width / 3.5)),
        const Text("张"),
        Expanded(child: Container())
      ];

  // 数量-百分比
  List<Widget> _numPercent() => [
        SizedBox(height: (width / 8)),
        Text(countNum.toString(),
            style: AppTextStyle.customStyle(size: width / 5)),
        Expanded(child: Container()),
        Text(countPercent, style: AppTextStyle.customSize(width / 7)),
        Expanded(child: Container()),
      ];

  // 排名-百分比
  List<Widget> _rankPercent() => [
        SizedBox(height: (width / 8)),
        Text(index, style: AppTextStyle.customStyle(size: width / 5)),
        Expanded(child: Container()),
        Text(countPercent, style: AppTextStyle.customSize(width / 7)),
        Expanded(child: Container()),
      ];

  // 排名-数量
  List<Widget> _rankNum() => [
        SizedBox(height: (width / 8)),
        Text(index, style: AppTextStyle.customStyle(size: width / 5)),
        Expanded(child: Container()),
        Text(countNum, style: AppTextStyle.customSize(width / 7)),
        Expanded(child: Container()),
      ];
}
