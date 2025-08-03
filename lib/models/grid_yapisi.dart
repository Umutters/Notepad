import 'package:flutter/material.dart';

class GridYapisi {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Color? cardColor;
  Color? textColor;
  bool? isBold; // ✅ Bold durumu
  bool? isItalic; // ✅ Italic durumu
  bool? isUnderline; // ✅ Underline durumu
   // ✅ Sayfa rengi

  GridYapisi({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.cardColor,
    this.textColor,
    this.isBold, // ✅ Format parametreleri eklendi
    this.isItalic,
    this.isUnderline,
  });

  // Factory constructor
  factory GridYapisi.fromMap(Map<String, dynamic> map) {
    return GridYapisi(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
      cardColor: map['Color'] != null
          ? Color(int.parse(map['Color']))
          : null,
      textColor: map['textColor'] != null
          ? Color(int.parse(map['textColor']))
          : null,
      isBold: map['isBold'] == 1, // ✅ Database'den format oku
      isItalic: map['isItalic'] == 1,
      isUnderline: map['isUnderline'] == 1,
    );
  }

  // toMap metodu
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'Color': cardColor?.withValues().toARGB32(),
      'textColor': textColor?.withValues().toARGB32(),
      'isBold': isBold == true ? 1 : 0, // ✅ Boolean'ı integer'a çevir
      'isItalic': isItalic == true ? 1 : 0,
      'isUnderline': isUnderline == true ? 1 : 0,
      
    };
  }
}