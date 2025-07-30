import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';

class Controller extends ChangeNotifier {
  List<GridYapisi> _grids = [];
  
  // Getter - grids listesini okumak için
  List<GridYapisi> get grids => _grids;
  
  // Setter - grids listesini güncellemek için
  set grids(List<GridYapisi> newGrids) {
    _grids = newGrids;
    notifyListeners(); // UI'yi güncelle
  }

  // Sıralama fonksiyonu
  void sort(String value) {
    List<GridYapisi> sortedGrids = List.from(_grids);
    
    // Tarihe göre sırala
    if (value == 'Tarihe Göre Sirala') {
      sortedGrids.sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
    } 
    // Değişim tarihine göre sırala
    else if (value == 'Değişim Tarihine Göre Sirala') {
      sortedGrids.sort((a, b) => (a.updatedAt ?? DateTime(0)).compareTo(b.updatedAt ?? DateTime(0)));
    } 
    // Başlığa göre sırala
    else if (value == 'Başliğa Göre Sirala') {
      sortedGrids.sort((a, b) => a.title!.compareTo(b.title!));
    }
    
    _grids = sortedGrids;
    notifyListeners(); // UI'yi güncelle
  }

  // Yeni not ekleme
  void addGrid(String title) {
    final newGrid = GridYapisi(
      id: _grids.length + 1,
      title: title,
      description: 'Yeni not içeriği',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _grids.add(newGrid);
    notifyListeners(); // UI'yi güncelle
  }

  // Not güncelleme
  void updateGrid(GridYapisi updatedGrid, int index) {
    if (index >= 0 && index < _grids.length) {
      _grids[index] = updatedGrid;
      notifyListeners(); // UI'yi güncelle
    }
  }

  // Not silme
  void removeGrid(int index) {
    if (index >= 0 && index < _grids.length) {
      _grids.removeAt(index);
      notifyListeners(); // UI'yi güncelle
    }
  }

  // Listeyi tersine çevirme
  void reverseGrids() {
    _grids = _grids.reversed.toList();
    notifyListeners(); // UI'yi güncelle
  }
}
