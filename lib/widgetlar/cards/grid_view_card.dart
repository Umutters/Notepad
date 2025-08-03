import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';
import 'package:umuttersnotlar/sayfalar/note_edit_page.dart';
import 'package:umuttersnotlar/widgetlar/widgets/show_colorpicker.dart';
import 'package:umuttersnotlar/widgetlar/widgets/show_dialog.dart';

class GridViewCard extends StatefulWidget {
  const GridViewCard({
    super.key, 
    required this.grids,
    this.onGridUpdate,
    this.onGridDelete,
    this.onGridTap,
    this.onColorChange,
  });
  final List<GridYapisi> grids;
  final Function(GridYapisi updatedGrid, int index)? onGridUpdate;
  final Function(int index)? onGridDelete;
  final Function(GridYapisi grid, int index, BuildContext context)? onGridTap;
  final Function(int,Color )? onColorChange;
  @override
  State<GridViewCard> createState() => _GridViewCardState();
}

class _GridViewCardState extends State<GridViewCard> {
  static const double _buttonSpacing = 40.0;

  @override
  Widget build(BuildContext context) {
    if (widget.grids.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'Henüz not eklenmemiş',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: widget.grids.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final grid = widget.grids[index];
          return _buildGridCard(context, grid, index);
        },
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, GridYapisi grid, int index) {
    return GestureDetector(
      onTap: () async {
        final updatedGrid = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEditPage(grid: grid),
          ),
        );
        if (updatedGrid != null && widget.onGridUpdate != null) {
          widget.onGridUpdate!(updatedGrid, index);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: grid.cardColor ?? Colors.white,
        elevation: 2,
        margin: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Başlık
                  Text(
                    grid.title ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // İçerik
                  Text(
                    grid.description ?? '',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: _buttonSpacing), // Alt butonlar için boşluk
                   // Alt butonlar için boşluk
                  
                  // Tarih
                  
                ],
              ),
            ),
            
            // Renk düzenleme butonu
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => showColorPicker(context: context, grid: grid, onColorSelected: (color) {
                  setState(() {
                    grid.cardColor = color;
                  });
                  if (widget.onColorChange != null) {
                    widget.onColorChange!(index, color);
                  }
                }),
                icon: const Icon(Icons.palette, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
            
            // Silme butonu
            Positioned(
              bottom: 8,
              left: 8,
              child: IconButton(
                onPressed: () => showDeleteDialog(context: context,onDelete: () => widget.onGridDelete!(index),),
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
            if (grid.createdAt != null)
                    Positioned(
                      bottom: 22.8,
                      right: 8,
                      child: Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(grid.createdAt!),
                        style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
          ],
        ),
      ),
    );
  }

 

}
