//文字灯牌-输入

import 'package:count_tools/page/component/toggle_button.dart';
import 'package:count_tools/page/dialog/color_picker_dialog.dart';
import 'package:count_tools/page/tool_page/child_tool/text_display_board_show.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:flutter/material.dart';

class TextDisplayBoard extends StatefulWidget {
  const TextDisplayBoard({Key? key}) : super(key: key);

  @override
  State<TextDisplayBoard> createState() => _TextDisplayBoardState();
}

class _TextDisplayBoardState extends State<TextDisplayBoard> {
  double _currentSpeed = 10;
  double _currentSliderValue = 30;
  final _controller = TextEditingController();
  final ValueNotifier<bool> _isScroll = ValueNotifier<bool>(false);
  final ValueNotifier<Color> _backColor = ValueNotifier<Color>(Colors.black);
  final ValueNotifier<Color> _textColor = ValueNotifier<Color>(Colors.white);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('文字灯牌')),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () => pushToShowPage(),
        ),
      );

  Widget _buildBody() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: ListView(
          children: [
            _buildInput(),
            const SizedBox(height: 18),
            _buildModelCheck(),
            const SizedBox(height: 18),
            _buildBackColorCheck(),
            const SizedBox(height: 18),
            _buildTextColorCheck(),
            const SizedBox(height: 18),
            _buildTextSizeSelect(),
            const SizedBox(height: 18),
            _buildScrollSpeedSelect(),
          ],
        ),
      );

  Widget _buildInput() => TextField(
      controller: _controller,
      maxLines: null,
      maxLength: 1000,
      decoration: InputDecoration(
          labelText: '请输入文本内容',
          prefixIcon: const Icon(Icons.text_fields),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))));

  Widget _buildModelCheck() => SizedBox(
      width: double.infinity,
      child: ToggleButtonWidget(
          leftText: '普通模式',
          rightText: '滚动模式',
          isLeftCheck: (bool value) => _isScroll.value = !value));

  Widget _buildBackColorCheck() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: ValueListenableBuilder<Color>(
          valueListenable: _backColor,
          builder: (context, color, child) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('背景颜色'),
                    Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)))
                  ]),
              onTap: () => pushToColorPicker(color, _backColor))));

  Widget _buildTextColorCheck() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: ValueListenableBuilder<Color>(
          valueListenable: _textColor,
          builder: (context, color, child) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('文字颜色'),
                    Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)))
                  ]),
              onTap: () => pushToColorPicker(color, _textColor))));

  Widget _buildTextSizeSelect() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('文字大小'),
        Slider(
            value: _currentSliderValue,
            min: 1,
            max: 100,
            divisions: 100,
            label: _currentSliderValue.toStringAsFixed(1),
            onChanged: (value) => setState(() => _currentSliderValue = value))
      ]));

  Widget _buildScrollSpeedSelect() => ValueListenableBuilder<bool>(
      valueListenable: _isScroll,
      builder: (context, isScroll, child) => AnimatedOpacity(
          opacity: isScroll ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('滚动速度'),
                  Slider(
                      value: _currentSpeed,
                      min: 1,
                      max: 100,
                      divisions: 50,
                      label: _currentSpeed.toStringAsFixed(1),
                      onChanged: (s) => setState(() => _currentSpeed = s))
                ]),
          )));

  void pushToColorPicker(Color color, ValueNotifier<Color> colorResult) =>
      showColorPicker(context, color, (c) => colorResult.value = c);

  void pushToShowPage() => RouteUtils.pushAnim(
      context,
      TextDisplayBoardShowPage(
          text: _controller.text,
          backColor: _backColor.value,
          textColor: _textColor.value,
          textSize: _currentSliderValue,
          speed: _isScroll.value ? _currentSpeed : null));
}
