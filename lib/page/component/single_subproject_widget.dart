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
              SizedBox(height: (width / 8)),
              Text(countNum.toString(),
                  style: AppTextStyle.customStyle(size: width / 5)),
              Expanded(child: Container()),
              Text(countPercent, style: AppTextStyle.customSize(width / 7)),
              Expanded(child: Container()),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: width / 5,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )),
                child: Text(name,
                    style: AppTextStyle.customStyle(
                        size: width / 7,
                        color: textColor,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
      );
}
