import 'package:flutter/material.dart';

class UpdatingProgressDialog extends StatelessWidget {
  final String message;
  final Color? progressIndicatorColor;
  final TextStyle? messageTextStyle;

  const UpdatingProgressDialog(
    this.message, {
    Key? key,
    this.progressIndicatorColor,
    this.messageTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Row(children: [
          CircularProgressIndicator(
              valueColor: progressIndicatorColor != null
                  ? AlwaysStoppedAnimation(progressIndicatorColor!)
                  : null),
          const SizedBox(width: 20),
          Text(message, style: messageTextStyle)
        ]),
      );
}
