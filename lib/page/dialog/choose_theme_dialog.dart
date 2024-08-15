import 'package:count_tools/utils/setting_utils.dart';
import 'package:flutter/material.dart';

class ColorPickerDialog extends StatelessWidget {
  final ValueChanged<bool> onColorChanged;

  const ColorPickerDialog({super.key, required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    final List<MaterialColor> colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    final List<String> colorStr = [
      "red",
      "pink",
      "purple",
      "deepPurple",
      "indigo",
      "blue",
      "lightBlue",
      "cyan",
      "teal",
      "green",
      "lightGreen",
      "lime",
      "yellow",
      "amber",
      "orange",
      "deepOrange",
      "brown",
      "grey",
      "blueGrey",
    ];

    return AlertDialog(
      title: const Text('主题颜色选择'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择您喜欢的主题颜色\n选择后需退出app重进才能生效'),
          const SizedBox(height: 16),
          SizedBox(
            width: 300,
            height: 400,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  SettingUtils.setThemeColor(colorStr[index]);
                  onColorChanged(true);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('取消'),
          onPressed: () {
            onColorChanged(false);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void showThemePicker(BuildContext context, ValueChanged<bool> onColorChanged) =>
    showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(onColorChanged: onColorChanged),
    );
