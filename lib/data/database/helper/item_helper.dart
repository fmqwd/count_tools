import 'package:count_tools/data/database/data_base.dart';
import 'package:count_tools/data/model/item_data.dart';
import 'package:sqflite/sqflite.dart';

class ItemDBHelper {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insert(ItemData data) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'item_data',
      {
        'id': data.id,
        'price': data.price,
        'eventName': data.eventName,
        'type': data.type,
        'date': data.date,
        'itemName': data.itemName,
        'parentId': data.parentId,
        'projectId': data.projectId,
        'ext': data.ext,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAll(List<ItemData> data) async {
    final db = await _databaseHelper.database;
    await db.transaction((txn) async {
      for (var item in data) {
        await txn.insert(
          'item_data',
          {
            'id': item.id,
            'price': item.price,
            'eventName': item.eventName,
            'type': item.type,
            'date': item.date,
            'itemName': item.itemName,
            'parentId': item.parentId,
            'projectId': item.projectId,
            'ext': item.ext,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<ItemData>> get() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('item_data');
    return List.generate(maps.length, (i) => ItemData.fromJson(maps[i]));
  }

  Future<List<ItemData>> getByParent(String parentId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'item_data',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
    return List.generate(maps.length, (i) => ItemData.fromJson(maps[i]));
  }

  Future<List<ItemData>> getByProject(String projectId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'item_data',
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
    return List.generate(maps.length, (i) => ItemData.fromJson(maps[i]));
  }

  Future<void> update(ItemData data) async {
    final db = await _databaseHelper.database;
    await db.update(
      'item_data',
      {
        'price': data.price,
        'eventName': data.eventName,
        'type': data.type,
        'date': data.date,
        'itemName': data.itemName,
        'parentId': data.parentId,
        'projectId': data.projectId,
        'ext': data.ext
      },
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  Future<void> updateAll(List<ItemData> data) async {
    final db = await _databaseHelper.database;
    await db.transaction((txn) async {
      for (var item in data) {
        await txn.update(
          'item_data',
          {
            'price': item.price,
            'eventName': item.eventName,
            'type': item.type,
            'date': item.date,
            'itemName': item.itemName,
            'parentId': item.parentId,
            'projectId': item.projectId,
            'ext': item.ext
          },
          where: 'id = ?',
          whereArgs: [item.id],
        );
      }
    });
  }

  Future<void> delete(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'item_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteByParent(String parentId) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'item_data',
      where: 'parentId = ?',
      whereArgs: [parentId],
    );
  }

  Future<void> deleteByProject(String projectId) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'item_data',
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
  }
}
