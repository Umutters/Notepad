import 'package:flutter/material.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';

class Controller extends ChangeNotifier {
  List<GridYapisi> _grids = [];

  List<GridYapisi> get grids => _grids;

  // Not ekle
  void addGrid(String title) {
    final newGrid = GridYapisi(
      title: title,
      description: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _grids.add(newGrid);
    notifyListeners();
  }

  // Not güncelle
  void updateGrid(GridYapisi updatedGrid, int index) {
    if (index >= 0 && index < _grids.length) {
      _grids[index] = updatedGrid;
      notifyListeners();
    }
  }

  // Not sil
  void removeGrid(int index) {
    if (index >= 0 && index < _grids.length) {
      _grids.removeAt(index);
      notifyListeners();
    }
  }

  // Listeyi tersine çevir
  void reverseGrids() {
    _grids = _grids.reversed.toList();
    notifyListeners();
  }

  // Arama yap
  void searchGrids(String query) {
    if (query.isEmpty) {
      // Tüm notları göster (bu kısım ihtiyacına göre ayarlanabilir)
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
}