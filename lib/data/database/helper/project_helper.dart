import 'package:count_tools/data/database/data_base.dart';
import 'package:count_tools/data/model/project_data.dart';
import 'package:sqflite/sqflite.dart';

class ProjectDBHelper {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insert(ProjectData data) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'project_data',
      {
        'title': data.title,
        'subTitle': data.subTitle,
        'count': data.count,
        'ext': data.ext,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProjectData>> get() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('project_data');
    return List.generate(maps.length, (i) => ProjectData.fromJson(maps[i]));
  }

  Future<void> update(ProjectData data) async {
    final db = await _databaseHelper.database;
    await db.update(
      'project_data',
      {
        'title': data.title,
        'subTitle': data.subTitle,
        'count': data.count,
        'ext': data.ext,
      },
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'project_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
