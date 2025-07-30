import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';
import 'package:umuttersnotlar/classlar/renkler.dart';

class NoteEditPage extends StatefulWidget {
  final GridYapisi grid;
  const NoteEditPage({super.key, required this.grid});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  bool isTextClicked=false;
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
      appBar: isTextClicked 
        ? AppBar(
            title: GestureDetector(
              onTap: () {
                setState(() {
                  isTextClicked = !isTextClicked;
                });
              },
              child: Text('Not Düzenle')
            )
          ) 
        : AppBar(
            title: Text('Not Düzenle'),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  // Güncellenen notu hazırla ve geri dön
                  final updatedGrid = GridYapisi(
                    id: widget.grid.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    createdAt: widget.grid.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(), // Güncelleme zamanını ayarla
                  );
                  
                  // Ana sayfaya güncellenen notu geri gönder
                  Navigator.pop(context, updatedGrid);
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
                  labelText: 'İçerik',
                  border: OutlineInputBorder(),
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
    );
  }
}
