import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';

class Services {
  // Database bağlantısı
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notepad_v2.sqlite'), // Adı değiştirildi
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, createdAt TEXT, updatedAt TEXT, Color TEXT)',
        );
      },
      version: 1,
    );
  }

  // Not ekleme
  static Future<void> insertGrid(GridYapisi grid) async {
    final db = await getDatabase();
    await db.insert('Notes', {
      'title': grid.title,
      'description': grid.description,
      'createdAt': grid.createdAt?.toIso8601String(), // ✅ String'e çevir
      'updatedAt': grid.updatedAt?.toIso8601String(),
      'Color': grid.cardColor?.value.toString(), // ✅ Renk değerini   String'e çevir
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Tüm notları getir
  static Future<List<GridYapisi>> getAllNotes() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('Notes');

    return List.generate(maps.length, (i) {
      return GridYapisi(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        createdAt: maps[i]['createdAt'] != null 
            ? DateTime.tryParse(maps[i]['createdAt']) // ✅ String'den DateTime'a çevir
            : null,
        updatedAt: maps[i]['updatedAt'] != null 
            ? DateTime.tryParse(maps[i]['updatedAt']) // ✅ String'den DateTime'a çevir
            : null,
            cardColor: maps[i]['Color'] != null
            ? Color(int.parse(maps[i]['Color'])) // Renk değerini al
            : null,
      );
    });
  }

  // Not güncelle
  static Future<void> updateGrid(GridYapisi grid) async {
    final db = await getDatabase();
    await db.update(
      'Notes',
      {
        'title': grid.title,
        'description': grid.description,
        'updatedAt': DateTime.now().toIso8601String(),
        'Color': grid.cardColor?.value.toString(), // Renk değerini kaydet
      },
      where: 'id = ?',
      whereArgs: [grid.id],
    );
  }

  // Not sil
  static Future<void> deleteGrid(int id) async {
    final db = await getDatabase();
    await db.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  static Future<void> testDatabase() async {
  final db = await getDatabase();
  final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Notes'));
  print('Toplam kayıt sayısı: $count');

  final allRecords = await db.rawQuery('SELECT * FROM Notes');
  print('Tüm kayıtlar: $allRecords');
}
}