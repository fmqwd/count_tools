import 'package:flutter/material.dart';

class DropDownTitle extends StatefulWidget {
  final String mainTitle;
  final List<String> titleList;
  final Function(String) onChanged;

  const DropDownTitle({
    super.key,
    required this.titleList,
    required this.onChanged,
    required this.mainTitle,
  });

  @override
  State<DropDownTitle> createState() => _DropDownTitleState();
}

class _DropDownTitleState extends State<DropDownTitle> {
  bool _isExpanded = false;
  String _selectedValue = '全部';

  void _onTap() {
    if (!_isExpanded) {
      showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(0, 50, 0, 0),
        items: widget.titleList
            .map((String item) => PopupMenuItem(value: item, child: Text(item)))
            .toList(),
        elevation: 8.0,
      ).then((String? selectedValue) {
        if (selectedValue != null) {
          _onSelected(selectedValue);
        } else {
          setState(() => _isExpanded = false);
        }
      });
    }

    setState(() => _isExpanded = !_isExpanded);
  }

  void _onSelected(String value) => setState(() => {
        _selectedValue = value,
        widget.onChanged(value),
        _isExpanded = false,
      });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: _onTap,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('${widget.mainTitle} $_selectedValue'),
        AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: _isExpanded ? 0.5 : 0.0,
            child: const Icon(Icons.arrow_drop_down))
      ]));
}
