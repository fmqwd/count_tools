import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_group_page_vm.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({super.key});

  @override
  State<AddGroupPage> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroupPage> {
  late AddGroupPageViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = AddGroupPageViewModel()..loadData();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
          appBar: AppBar(title: const Text('新增团体')),
          body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(labelText: '团体名'),
                        maxLength: 50,
                        onChanged: (value) => _vm.groupName = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入团体名';
                          }
                          return null;
                    }),
                const SizedBox(height: 16),
                GestureDetector(
                    child: _buildAvatar(), onTap: () => _vm.pickImage(context)),
                const SizedBox(height: 16),
                TextFormField(
                        decoration: const InputDecoration(labelText: '介绍'),
                        maxLines: 5,
                        minLines: 1,
                        maxLength: 1000,
                        onChanged: (value) => _vm.groupDescription = value),
                    const SizedBox(height: 16),
                    TextFormField(
                        decoration: const InputDecoration(labelText: '所在地'),
                        maxLength: 20,
                        onChanged: (value) => _vm.location = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入所在地';
                          }
                          return null;
                        }),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => _vm.submitForm(context),
                        child: const Text('提交'))
                  ]))));

  Widget _buildAvatar() =>
      Consumer<AddGroupPageViewModel>(builder: (context, vm, _) {
        if (vm.groupImage != null) {
          return Image.file(_vm.groupImage!,
              height: 100, width: double.infinity, fit: BoxFit.cover);
        } else {
          return Container(
              height: 100,
              width: 100,
              color: Colors.grey[200],
              child: const Center(child: Text('无头像')));
        }
      });
}
