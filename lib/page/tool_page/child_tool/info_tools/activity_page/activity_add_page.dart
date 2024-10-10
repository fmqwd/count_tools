import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_add_page_vm.dart';

class ActivityAddPage extends StatefulWidget {
  const ActivityAddPage({super.key});

  @override
  State<ActivityAddPage> createState() => _ActivityAddPageState();
}

class _ActivityAddPageState extends State<ActivityAddPage> {
  late ActivityAddPageViewModel _vm;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        appBar: AppBar(title: const Text('添加活动')),
        body: const Center(child: Text('添加活动')),
      ));
}
