import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onChanged;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onChanged,
  });

  @override
  State<ColorPickerDialog> createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog>
    with ChangeNotifier {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  void onColorChanged(Color color) => setState(() {
        currentColor = color;
        notifyListeners();
        widget.onChanged(color);
      });

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('选择颜色'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: currentColor,
                onColorChanged: onColorChanged,
                pickerAreaHeightPercent: 0.8),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ColorOption(color: Colors.red, onChanged: onColorChanged),
                  ColorOption(color: Colors.pink, onChanged: onColorChanged),
                  ColorOption(color: Colors.orange, onChanged: onColorChanged),
                  ColorOption(color: Colors.yellow, onChanged: onColorChanged),
                  ColorOption(color: Colors.green, onChanged: onColorChanged),
                  ColorOption(color: Colors.cyan, onChanged: onColorChanged),
                  ColorOption(color: Colors.blue, onChanged: onColorChanged),
                  ColorOption(color: Colors.purple, onChanged: onColorChanged),
                  ColorOption(color: Colors.white, onChanged: onColorChanged),
                  ColorOption(color: Colors.black, onChanged: onColorChanged)
                ])),
          ],
        ),
        actions: [
          TextButton(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop())
        ],
      );
}

class ColorOption extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onChanged;

  const ColorOption({Key? key, required this.color, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => onChanged(color),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          width: 50,
          height: 50));
}

void showColorPicker(
  BuildContext context,
  Color initialColor,
  ValueChanged<Color> changed,
) => showDialog(context: context, builder: (context) =>
    ColorPickerDialog(initialColor: initialColor, onChanged: changed));