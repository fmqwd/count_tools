import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddGroupPageViewModel extends ChangeNotifier {
  String _groupName = '';
  File? _groupImage;
  String _groupDescription = '';
  String _location = '';

  String get groupName => _groupName;

  File? get groupImage => _groupImage;

  String get groupDescription => _groupDescription;

  String get location => _location;

  set groupName(String value) {
    _groupName = value;
    notifyListeners();
  }

  set groupImage(File? value) {
    _groupImage = value;
    notifyListeners();
  }

  set groupDescription(String value) {
    _groupDescription = value;
    notifyListeners();
  }

  set location(String value) {
    _location = value;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    // 请求权限
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        groupImage = File(pickedFile.path);
      }
    } else {
      // 处理权限被拒绝的情况
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请授予存储权限以选择图片')),
        );
      }
    }
  }

  bool validateForm() {
    if (_groupName.isEmpty || _location.isEmpty) {
      return false;
    }
    return true;
  }

  void submitForm(BuildContext context) {
    if (validateForm()) {
      // 这里可以添加提交逻辑
    } else {
      // 显示错误提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写必填项')),
      );
    }
  }

  Future<void> loadData() async {
    notifyListeners();
  }
}
