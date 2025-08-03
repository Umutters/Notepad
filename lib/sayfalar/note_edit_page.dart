import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:umuttersnotlar/Services/services.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';
import 'package:umuttersnotlar/theme/renkler.dart';
import 'package:umuttersnotlar/widgetlar/BottomNavigationBar/bottom_navigatin_bar.dart';

class NoteEditPage extends StatefulWidget {
  final GridYapisi grid;
  const NoteEditPage({super.key, required this.grid});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late QuillController _quillController;
  Color? selectedCardColor;
  Color? selectedTextColor;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();
    _quillController.document.insert(0, widget.grid.description ?? '');
    titleController = TextEditingController(text: widget.grid.title);
    descriptionController = TextEditingController(text: widget.grid.description);
    selectedCardColor = widget.grid.cardColor;
    selectedTextColor = widget.grid.textColor;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _quillController.dispose();
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
                       Navigator.of(context).pop();
                       
                       });
                      
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
                  final plainText = _quillController.document.toPlainText();
                  // Güncellenen notu hazırla ve geri dön
                  final updatedGrid = GridYapisi(
                    id: widget.grid.id,
                    title: titleController.text,
                    description: plainText,
                    createdAt: widget.grid.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(),
                    cardColor: selectedCardColor ?? widget.grid.cardColor,
                    textColor: selectedTextColor ?? widget.grid.textColor,
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
      body: Column(
        children: [ 
          
            SizedBox(height: 16),
            SingleChildScrollView(
              child: TextField(
                
                controller: descriptionController,
                style: TextStyle(fontSize: 16,color: selectedTextColor ?? Colors.black),
                decoration: InputDecoration(
                
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor:widget.grid.cardColor ?? Colors.white,
                ),
                maxLines: 8,
              ),
            ),
          
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(textController: descriptionController, onColorChanged: (value) => setState(() => selectedTextColor = value), selectedColor: selectedTextColor, currentIndex: _selectedIndex, onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        
      }),
      backgroundColor: Renkler.scaffoldColor,
    );
    
  }
}
