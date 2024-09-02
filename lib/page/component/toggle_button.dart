import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatefulWidget {
  final String leftText;
  final String rightText;

  final void Function(bool) isLeftCheck;

  const ToggleButtonWidget(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.isLeftCheck});

  @override
  ToggleButtonWidgetState createState() => ToggleButtonWidgetState();
}

class ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  int _selectedIndex = 0;

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
      widget.isLeftCheck(_selectedIndex == 0);
    });
  }

  @override
  Widget build(BuildContext context) => ToggleButtons(
        onPressed: _onToggle,
        borderRadius: BorderRadius.circular(12),
        isSelected: [_selectedIndex == 0, _selectedIndex == 1],
        children: [
          Container(
              width: (MediaQuery.of(context).size.width - 36) / 2,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.leftText)),
          Container(
              width: (MediaQuery.of(context).size.width - 36) / 2,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.rightText))
        ],
      );
}
