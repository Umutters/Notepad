import 'package:umuttersnotlar/controller/controller.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';

class NotesService {
  final Controller controller;
  
  NotesService(this.controller);

  // Tüm notları al
  List<GridYapisi> getAllNotes() {
    return controller.grids;
  }

  // Belirli bir not bul (ID ile)
  GridYapisi? findNoteById(int id) {
    try {
      return controller.grids.firstWhere((grid) => grid.id == id);
    } catch (e) {
      return null; // Bulunamazsa null döndür
    }
  }

  // Başlığa göre not ara
  List<GridYapisi> searchByTitle(String query) {
    return controller.grids
        .where((grid) => grid.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Son eklenen notları al (son 5 not)
  List<GridYapisi> getRecentNotes() {
    List<GridYapisi> sortedByDate = List.from(controller.grids);
    sortedByDate.sort((a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
    return sortedByDate.take(5).toList();
  }

  // Not sayısını al
  int getNotesCount() {
    return controller.grids.length;
  }

  // Boş notları temizle
  void clearEmptyNotes() {
    controller.grids.removeWhere((grid) => 
        grid.title?.isEmpty == true && grid.description?.isEmpty == true);
  }

  // Yedek alma (JSON formatında export için)
  List<Map<String, dynamic>> exportNotes() {
    return controller.grids.map((grid) => {
      'id': grid.id,
      'title': grid.title,
      'description': grid.description,
      'createdAt': grid.createdAt?.toIso8601String(),
      'updatedAt': grid.updatedAt?.toIso8601String(),
    }).toList();
  }
}
