import 'package:flutter/material.dart';

class NonePaddingWidget extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final bool removeTop;
  final bool removeBottom;
  final bool removeLeft;
  final bool removeRight;

  const NonePaddingWidget({
    Key? key,
    required this.context,
    required this.child,
    this.removeTop = true,
    this.removeBottom = true,
    this.removeLeft = false,
    this.removeRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
      context: context,
      removeTop: removeTop,
      removeBottom: removeBottom,
      removeLeft: removeLeft,
      removeRight: removeRight,
      child: child);
}
