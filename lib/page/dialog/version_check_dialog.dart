import 'dart:convert';
import 'package:count_tools/utils/log.dart';
import 'package:count_tools/utils/route_utils.dart';
import 'package:count_tools/value/info.dart';
import 'package:count_tools/value/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VersionUpdateChecker {
  final BuildContext context;

  VersionUpdateChecker(this.context);

  Future<void> checkForUpdates() async {
    const versionCheckUrl = AppUrl.updateUrl;
    final currentVersion = AppInfo.appVersion;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: Row(children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("检查更新...")
              ]),
            ));
    try {
      final response = await get(Uri.parse(versionCheckUrl));
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (response.statusCode == 200) {
        final jsonBody = utf8.decode(response.bodyBytes);
        final data = json.decode(jsonBody);
        final newVersion = data['version'];
        final updateContent = data['update_content'];
        final downloadUrl = data['download_url'];

        if (isNewVersionAvailable(currentVersion, newVersion)) {
          _showUpdateDialog(updateContent, downloadUrl);
        } else {
          _showUnUpdateDialog();
        }
      } else {
        _showErrorDialog("更新检查失败，请稍后再试。");
      }
    } catch (e) {
      Navigator.of(context).pop();
      Log.e('VersionUpdateChecker', 'Error checking for updates: $e');
      _showErrorDialog("网络异常，请检查连接");
    }
  }

  void _showErrorDialog(String message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text('错误'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('我知道了'))
              ]));

  bool isNewVersionAvailable(String current, String newVersion) =>
      compareVersions(current, newVersion) < 0;

  int compareVersions(String v1, String v2) {
    final List<int> v1Parts = v1.split('.').map(int.parse).toList();
    final List<int> v2Parts = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < v1Parts.length; i++) {
      if (i >= v2Parts.length) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
      if (v1Parts[i] > v2Parts[i]) return 1;
    }
    return v1Parts.length == v2Parts.length ? 0 : -1;
  }

  void _showUpdateDialog(String updateContent, String url) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text('有新的版本可以更新'),
              content: Text(updateContent),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('我知道了')),
                TextButton(
                    onPressed: () {
                      RouteUtils.launchURL(url);
                      Navigator.of(context).pop();
                    },
                    child: const Text('更新'))
              ]));

  void _showUnUpdateDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text('当前已是最新版本'),
              content: const Text('当前已是最新版本，无需更新'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('我知道了'))
              ]));
}
