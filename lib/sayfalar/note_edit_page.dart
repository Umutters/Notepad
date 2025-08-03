import 'package:flutter/material.dart';
import 'package:umuttersnotlar/Services/services.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';
import 'package:umuttersnotlar/theme/renkler.dart';

class NoteEditPage extends StatefulWidget {
  final GridYapisi grid;
  const NoteEditPage({super.key, required this.grid});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {

  Color? selectedColor;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.grid.title);
    descriptionController = TextEditingController(text: widget.grid.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: widget.grid.title == null || widget.grid.title!.isEmpty
            ? Text('Yeni Not')
            : Text(widget.grid.title!),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Not Başlığı',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
                  content: TextField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Başlık girin'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        widget.grid.title = titleController.text;
                       });
                      Navigator.of(context).pop();
                    },
                    child: Text('Tamam'),
                  ),
                ],
              );
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
                onPressed: () async{
                  // Güncellenen notu hazırla ve geri dön
                  final updatedGrid = GridYapisi(
                    id: widget.grid.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    createdAt: widget.grid.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(),
                    cardColor: selectedColor ?? widget.grid.cardColor,
                  );
                  if (updatedGrid.id != null) {
              await Services.updateGrid(updatedGrid);
    }
                  // Ana sayfaya güncellenen notu geri gönder
                  if(context.mounted) {
                    Navigator.pop(context, updatedGrid);
                  }
                },
              ),
            ],
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
            ),*/
            SizedBox(height: 16),
            SingleChildScrollView(
              child: TextField(
                
                controller: descriptionController,
                style: TextStyle(fontSize: 16,color: selectedColor ?? Colors.black),
                decoration: InputDecoration(
                 
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor:widget.grid.cardColor ?? Colors.white,
                ),
                maxLines: 8,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                
                  crossAxisCount:Renkler.renkler.length,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 20,
                ),
                itemCount: Renkler.renkler.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Renk seçildiğinde, notun rengini güncelle
                      setState(() {
                        selectedColor = Renkler.renkler[index];
                      });
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Renkler.renkler[index],
                      
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      backgroundColor: Renkler.scaffoldColor,
    );
    
  }
}
