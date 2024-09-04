import 'package:count_tools/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class TextDisplayBoardShowPage extends StatefulWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final Color backColor;
  final double? speed;

  const TextDisplayBoardShowPage({
    Key? key,
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.backColor,
    this.speed,
  }) : super(key: key);

  @override
  State<TextDisplayBoardShowPage> createState() => _TextDisplayBoardShowState();
}

class _TextDisplayBoardShowState extends State<TextDisplayBoardShowPage> {
  late ScrollController _scrollController;
  Timer? _timer;
  double _position = 0;

  @override
  void initState() {
    super.initState();
    setScreenOrientation(true);

    if (widget.speed != null) {
      _scrollController = ScrollController();
      _startScrolling();
    }
  }

  void _startScrolling() {
    final speed = widget.speed!;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _position += speed;
        if (_position > _scrollController.position.maxScrollExtent) {
          _position = 0;
        }
      });
      _scrollController.jumpTo(_position);
    });
  }

  @override
  void dispose() {
    setScreenOrientation(false);
    if (widget.speed != null) {
      _timer?.cancel();
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
          child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              color: widget.backColor,
              child: widget.speed != null ? _buildScroll() : _buildText())));

  Widget _buildScroll() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Center(child: _buildText()));

  Widget _buildText() => Text(widget.text,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: TextStyle(color: widget.textColor, fontSize: getSize()));

  double getSize() =>
      (MediaQuery.of(context).size.height / 2) * (widget.textSize / 100) +
      (MediaQuery.of(context).size.height / 2);
}
