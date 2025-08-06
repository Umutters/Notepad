import 'package:flutter/material.dart';
import 'package:umuttersnotlar/Services/background_themes.dart';
import 'package:umuttersnotlar/Services/services.dart';
import 'package:umuttersnotlar/Services/theme_helper.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';

class Controller extends ChangeNotifier {
  List<GridYapisi> _grids = [];
  bool _isLoading = false;

  List<GridYapisi> get grids => _grids;
  bool get isLoading => _isLoading;
  // Not ekle
Future <void>loadGrids()async{
  _isLoading = true;
  notifyListeners();
  _grids = await Services.getAllGrids();
  _isLoading = false;
  notifyListeners();
  // Test amaçlı veritabanı kontrolü
}

  Future<void> addGrid(String title, BuildContext context) async {
    final newGrid = GridYapisi(
      title: title,
      description: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cardColor: ThemeHelper.getCardColor(context),
      textColor: ThemeHelper.getTextColor(context),
      isBold: false,
      isItalic: false,
      isUnderline: false,
    );
    await Services.insertGrid(newGrid);
    await loadGrids();
  }

  // Not güncelle
  Future<void> updateGrid(GridYapisi updatedGrid, int index) async {    
      await Services.updateGrid(updatedGrid);
      await loadGrids();
    
  }

  //toggletheme yap
  void toggleTheme() {
    ThemeProvider().toggleTheme();
  }
  // Not sil
  /*Future<void> deleteGrid(int id) async {
    await Services.deleteGrid(id);
    await loadGrids();
  }*/

  // Listeyi tersine çevir
  void reverseGrids() {
    _grids = _grids.reversed.toList();
    notifyListeners();
  }

  // Arama yap
  void searchGrids(String query) {
    if (query.isEmpty) {
      loadGrids(); // Tüm notları göster
    } else {
      _grids = _grids.where((grid) =>
        (grid.title?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
        (grid.description?.toLowerCase().contains(query.toLowerCase()) ?? false)
      ).toList();
      notifyListeners();
    }
  }

  // Sıralama
  void sortGrids(String sortType) {
    switch (sortType) {
      case 'Tarihe Göre Sirala':
        _grids.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
        break;
      case 'Değişim Tarihine Göre Sirala':
        _grids.sort((a, b) => (b.updatedAt ?? DateTime.now()).compareTo(a.updatedAt ?? DateTime.now()));
        break;
      case 'Başliğa Göre Sirala':
        _grids.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
        break;
    }
    notifyListeners();
  }
  Future<void> removeGrid(int index) async {
  if (index >= 0 && index < _grids.length) {
    final grid = _grids[index];
    if (grid.id != null) {
      await Services.deleteGrid(grid.id!); // ID'yi deleteGrid'e gönder
      await loadGrids();
    }
  }
}
}