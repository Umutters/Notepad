import 'package:flutter/material.dart';
class GridYapisi{
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Color? cardColor;
  GridYapisi({required this.id, required this.title, required this.description, this.createdAt, this.updatedAt, this.cardColor});
}