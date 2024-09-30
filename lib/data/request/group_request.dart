import 'package:count_tools/data/database/helper/group_helper.dart';
import 'package:count_tools/data/model/group_data.dart';
import 'package:count_tools/utils/log.dart';
import 'package:count_tools/utils/net_utils.dart';
import 'package:count_tools/value/url.dart';

class GroupRest {
  final groupDBHelper = GroupDBHelper();

  /// 获取全部团体信息并存储
  Future<void> fetchGroups() async {
    try {
      final response = await NetUtils.get("${AppUrl.groupUrl}/get_group.php");
      List<dynamic> body = response['message'];
      List<GroupData> groups =
          body.map((dynamic item) => GroupData.fromJson(item)).toList();
      for (var group in groups) {
        await groupDBHelper.insert(group);
      }
    } catch (e) {
      Log.e("GroupRest", e.toString());
    }
  }


}
