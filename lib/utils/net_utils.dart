import 'dart:convert';
import 'dart:io';

import 'package:count_tools/value/url.dart';
import 'package:http/http.dart' as http;

class NetUtils {
  static Map<String, String> _globalHeaders = {}; // 全局请求头

  /// 设置全局请求头
  static void setGlobalHeaders(Map<String, String> headers) {
    _globalHeaders = headers;
  }

  /// 发送GET请求
  static Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    try {
      final response =
          await http.get(uri, headers: {..._globalHeaders, ...?headers});
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// 发送POST请求
  static Future<Map<String, dynamic>> post(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          headers: {..._globalHeaders, ...?headers}, body: jsonEncode(body));
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// 处理响应
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] != null &&
          responseBody['status'] == 'success') {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } else {
      throw Exception(
          'Request failed with status: ${response.statusCode}. Response: ${response.body}');
    }
  }

  /// 选择本地图片并上传
  static Future<Map<String, dynamic>> uploadImage(String type, File image) async {
    final uri = Uri.parse("${AppUrl.imageUrl}/add_image.php");

    try {
      var request = http.MultipartRequest("POST", uri)
        ..fields['image_type'] = type
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      // 添加全局请求头
      request.headers.addAll(_globalHeaders);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        throw Exception(
            'Upload failed with status: ${response.statusCode}. Response: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
