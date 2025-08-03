import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';

class Services {
  // Database bağlantısı
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notepad_v5.sqlite'), // ✅ Versiyon artırıldı
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE grids(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            description TEXT, 
            createdAt TEXT, 
            updatedAt TEXT, 
            Color TEXT, 
            textColor TEXT,
            isBold INTEGER DEFAULT 0,
            isItalic INTEGER DEFAULT 0,
            isUnderline INTEGER DEFAULT 0,
            pageColor TEXT
          )''', // ✅ Format kolonları eklendi
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
      'Color': grid.cardColor?.withValues().toARGB32(),
      'textColor': grid.textColor?.withValues().toARGB32(),
      'isBold': grid.isBold == true ? 1 : 0, // ✅ Boolean'ı integer'a çevir
      'isItalic': grid.isItalic == true ? 1 : 0,
      'isUnderline': grid.isUnderline == true ? 1 : 0,
      
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
            ? Color(int.parse(maps[i]['textColor']))
            : null,
        isBold: maps[i]['isBold'] == 1, // ✅ Integer'ı boolean'a çevir
        isItalic: maps[i]['isItalic'] == 1,
        isUnderline: maps[i]['isUnderline'] == 1,

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
        'Color': grid.cardColor?.withValues().toARGB32(),
        'textColor': grid.textColor?.withValues().toARGB32(),
        'isBold': grid.isBold == true ? 1 : 0, // ✅ Format durumlarını kaydet
        'isItalic': grid.isItalic == true ? 1 : 0,
        'isUnderline': grid.isUnderline == true ? 1 : 0,
       
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
}