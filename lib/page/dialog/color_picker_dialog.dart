import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void showColorPicker(BuildContext context, Color initialColor,
        ValueChanged<Color> onColorChanged) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('选择颜色'),
                content: SingleChildScrollView(
                    child: ColorPicker(
                        pickerColor: initialColor,
                        onColorChanged: onColorChanged,
                        pickerAreaHeightPercent: 0.8)),
                actions: [
                  TextButton(
                      child: const Text('确定'),
                      onPressed: () => Navigator.of(context).pop())
                ]));
