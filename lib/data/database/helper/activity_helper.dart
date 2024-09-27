import 'package:count_tools/data/database/data_base.dart';
import 'package:count_tools/data/model/activity_data.dart';
import 'package:sqflite/sqflite.dart';

class ActivityDBHelper {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insert(ActivityData data) async {
    final db = await _dbHelper.database;
    await db.insert(
      'activity_data',
      {
        'id': data.id,
        'name': data.name,
        'desc': data.desc,
        'date': data.date,
        'time': data.time,
        'address': data.address,
        'price': data.price,
        'chikaNum': data.chikaNum,
        'peopleNum': data.peopleNum,
        'ext': data.ext,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ActivityData>> query() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('activity_data');
    return List.generate(maps.length, (i) => ActivityData.fromJson(maps[i]));
  }

  Future<void> update(ActivityData data) async {
    final db = await _dbHelper.database;
    await db.update('activity_data', {
      'id': data.id,
      'name': data.name,
      'desc': data.desc,
      'date': data.date,
      'time': data.time,
      'address': data.address,
      'price': data.price,
      'chikaNum': data.chikaNum,
      'peopleNum': data.peopleNum,
      'ext': data.ext,
    });
  }

  Future<void> delete(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'activity_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
