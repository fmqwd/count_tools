import 'package:count_tools/data/database/data_base.dart';
import 'package:count_tools/data/model/group_data.dart';

class GroupDBHelper {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insert(GroupData data) async {
    final db = await _dbHelper.database;
    await db.insert('group_data', {
      'id': data.id,
      'avatar_url': data.avatarUrl,
      'description': data.description,
      'name': data.name,
      'location': data.location,
      'extra_info': data.extraInfo,
      'members': data.members,
      'social_media_list': data.socialMedia,
    });
  }

  Future<List<GroupData>> query() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('group_data');
    return List.generate(maps.length, (i) => GroupData.fromJson(maps[i]));
  }

  Future<void> update(GroupData data) async {
    final db = await _dbHelper.database;
    await db.update(
        'group_data',
        {
          'avatarUrl': data.avatarUrl,
          'description': data.description,
          'name': data.name,
          'location': data.location,
          'extraInfo': data.extraInfo,
          'members': data.members,
          'socialMedia': data.socialMedia,
        },
        where: 'id = ?',
        whereArgs: [data.id]);
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete('group_data', where: 'id = ?', whereArgs: [id]);
  }
}
