import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';
import 'package:umuttersnotlar/sayfalar/note_edit_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import the color picker package

class GridViewCard extends StatefulWidget {
  const GridViewCard({
    super.key, 
    required this.grids,
    this.onGridUpdate,
  });
  final List<GridYapisi> grids;
  final Function(GridYapisi updatedGrid, int index)? onGridUpdate;
  @override
  State<GridViewCard> createState() => _GridViewCardState();
}

class _GridViewCardState extends State<GridViewCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, deger) {
        return GestureDetector(
          onTap: () async {
            final updatedGrid = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditPage(grid: widget.grids[deger]),
              ),
            );
            if (updatedGrid != null && widget.onGridUpdate != null) {
              widget.onGridUpdate!(updatedGrid, deger);
            }
          },
          child: Card(
            color: widget.grids[deger].cardColor ?? Colors.white,
            elevation: 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text('${widget.grids[deger].title}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.grids[deger].description}'),
                          IconButton(onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("renk seç"),
                                content: ColorPicker(
                                  
                                  pickerColor: widget.grids[deger].cardColor ?? Colors.white,
                                  onColorChanged: (color) {
                                 widget.grids[deger].cardColor = color;
                                
                                },
                              ),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {});
                                }, child: Text("Tamam")),
                              ],),
                            );
                          }, icon: Icon(Icons.edit)),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Silmek İstediğinize Emin Misiniz?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('İptal'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.grids.removeAt(deger);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Sil'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.grids[deger].createdAt != null
                        ? DateFormat('dd.MM.yyyy HH:mm').format(widget.grids[deger].createdAt!)
                        : '',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.grids.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}