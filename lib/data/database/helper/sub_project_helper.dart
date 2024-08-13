import 'package:count_tools/data/database/data_base.dart';
import 'package:count_tools/data/model/sub_project_data.dart';
import 'package:sqflite/sqflite.dart';

class SubProjectDbHelper {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insert(SubProjectData data) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'sub_project_data',
      {
        'id': data.id,
        'name': data.name,
        'count': data.count,
        'countPre': data.countPre,
        'color': data.color,
        'textColor': data.textColor,
        'parentId': data.parentId,
        'ext': data.ext,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SubProjectData>> get() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('sub_project_data');
    return List.generate(maps.length, (i) => SubProjectData.fromJson(maps[i]));
  }

  Future<List<SubProjectData>> getByParent(String parentId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sub_project_data',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
    return List.generate(maps.length, (i) => SubProjectData.fromJson(maps[i]));
  }

  Future<void> update(SubProjectData data) async {
    final db = await _databaseHelper.database;
    await db.update(
      'sub_project_data',
      {
        'name': data.name,
        'count': data.count,
        'countPre': data.countPre,
        'color': data.color,
        'textColor': data.textColor,
        'parentId': data.parentId,
        'ext': data.ext,
      },
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'sub_project_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteByParent(String parentId) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'sub_project_data',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
  }
}
