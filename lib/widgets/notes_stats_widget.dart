import 'package:flutter/material.dart';
import 'package:umuttersnotlar/controller/controller.dart';

class NotesStatsWidget extends StatelessWidget {
  final Controller controller;
  
  const NotesStatsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Controller'dan grids listesine erişim
    final totalNotes = controller.grids.length;
    final notesWithContent = controller.grids
        .where((grid) => grid.description?.isNotEmpty == true)
        .length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Not İstatistikleri',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Toplam Not: $totalNotes'),
            Text('İçerikli Not: $notesWithContent'),
            Text('Boş Not: ${totalNotes - notesWithContent}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Yeni not ekle
                controller.addGrid('Yeni Not ${totalNotes + 1}');
              },
              child: const Text('Hızlı Not Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
