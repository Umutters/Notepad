import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';

class Services {
  // Database bağlantısı
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notepad_v3.sqlite'), // Adı değiştirildi
      onCreate: (db, version) {
        // Tablo oluşturma (eğer yeni tablo oluşturuyorsan)
        return db.execute(
          'CREATE TABLE grids(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, createdAt TEXT, updatedAt TEXT, Color TEXT, textColor TEXT)', // ✅ textColor kolonu ekle
        );
      },
      version: 1,
    );
  }

  // Not ekleme
  static Future<void> insertGrid(GridYapisi grid) async {
    final db = await getDatabase();
    await db.insert('grids', {
      'title': grid.title,
      'description': grid.description,
      'createdAt': grid.createdAt?.toIso8601String(),
      'updatedAt': grid.updatedAt?.toIso8601String(),
      'Color': grid.cardColor?.toARGB32().toString(),
      'textColor': grid.textColor?.toARGB32().toString(), // ✅ textColor kaydet
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Tüm notları getir
  static Future<List<GridYapisi>> getAllGrids() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('grids');

    return List.generate(maps.length, (i) {
      return GridYapisi(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        createdAt: maps[i]['createdAt'] != null
            ? DateTime.tryParse(maps[i]['createdAt'])
            : null,
        updatedAt: maps[i]['updatedAt'] != null
            ? DateTime.tryParse(maps[i]['updatedAt'])
            : null,
        cardColor: maps[i]['Color'] != null
            ? Color(int.parse(maps[i]['Color']))
            : null,
        textColor: maps[i]['textColor'] != null
            ? Color(int.parse(maps[i]['textColor'])) // ✅ textColor oku
            : null,
      );
    });
  }

  // Not güncelle
  static Future<void> updateGrid(GridYapisi grid) async {
    final db = await getDatabase();
    await db.update(
      'grids',
      {
        'title': grid.title,
        'description': grid.description,
        'updatedAt': DateTime.now().toIso8601String(),
        'Color': grid.cardColor?.toARGB32().toString(),
        'textColor': grid.textColor?.toARGB32().toString(), // ✅ textColor güncelle
      },
      where: 'id = ?',
      whereArgs: [grid.id],
    );
  }

  // Not sil
  static Future<void> deleteGrid(int id) async {
    final db = await getDatabase();
    await db.delete(
      'grids',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  /*static Future<void> testDatabase() async {
  final db = await getDatabase();
  final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM grids')) ?? 0;
  print('Toplam kayıt sayısı: $count');

  final allRecords = await db.rawQuery('SELECT * FROM grids');
  print('Tüm kayıtlar: $allRecords');
}*/
}