import 'package:flutter/material.dart';
import 'package:umuttersnotlar/Services/services.dart';
import 'package:umuttersnotlar/models/grid_yapisi.dart';
//import 'package:umuttersnotlar/theme/renkler.dart';
import 'package:umuttersnotlar/widgetlar/BottomNavigationBar/bottom_navigatin_bar.dart';
import 'package:umuttersnotlar/Services/theme_helper.dart';

class NoteEditPage extends StatefulWidget {
  final GridYapisi grid;
  const NoteEditPage({super.key, required this.grid});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  
  Color? selectedCardColor;
  Color? selectedTextColor;
   TextEditingController? titleController;
  late TextEditingController descriptionController;
  int _selectedIndex = 0;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false; // ✅ Altı çizili kontrolü
  @override
  void initState() {
    super.initState();
    
   
    titleController = TextEditingController(text: widget.grid.title);
    descriptionController = TextEditingController(text: widget.grid.description);
    selectedCardColor = widget.grid.cardColor;
    selectedTextColor = widget.grid.textColor;
     // ✅ Database'den sayfa rengi
    
    // ✅ Database'den format durumlarını al
    _isBold = widget.grid.isBold ?? false;
    _isItalic = widget.grid.isItalic ?? false;
    _isUnderline = widget.grid.isUnderline ?? false;
  }

  @override
  void dispose() {
    titleController?.dispose();
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
                        widget.grid.title = titleController?.text ?? '';
                        // Başlık değiştiğinde sayfayı güncelle
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
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
                  final description = descriptionController.text;
                  final title = titleController?.text ?? '';
  
                  final updatedGrid = GridYapisi(
                    id: widget.grid.id,
                    title: title,
                    description: description,
                    createdAt: widget.grid.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(),
                    cardColor: selectedCardColor ?? widget.grid.cardColor,
                    textColor: selectedTextColor ?? widget.grid.textColor,
                    isBold: _isBold, // ✅ Format durumlarını kaydet
                    isItalic: _isItalic,
                    isUnderline: _isUnderline,
                    
                  );
  
                  if (updatedGrid.id != null) {
                    await Services.updateGrid(updatedGrid);
                   // print('Not kaydedildi: ${updatedGrid.title}');
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

            
            Expanded(
              child: Container(
                color: selectedCardColor ?? widget.grid.cardColor ?? Colors.white,
                padding: EdgeInsets.all(16),
                child: TextField(
                  
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedTextColor ?? Colors.black,
                    fontWeight: _isBold ? FontWeight.bold : FontWeight.normal, // ✅ Bold kontrolü
                    fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal, // ✅ Italic kontrolü
                    decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    
                    border: InputBorder.none,
                    hintText: 'Metni seçip format butonlarını kullanın...',
                  ),
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
          
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        textController: descriptionController,
        onColorChanged: (value) => setState(() => selectedTextColor = value),
        onFormatChanged: (format, isActive) { // ✅ Format callback
          setState(() {
            if (format == 'bold') _isBold = !_isBold;
            if (format == 'italic') _isItalic = !_isItalic;
            if (format == 'underline') _isUnderline = !_isUnderline; // ✅ Altı çizili kontrolü
          });
        },
        selectedColor: selectedTextColor,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
      backgroundColor: ThemeHelper.getScaffoldColor(context), // ✅ Theme'dan otomatik al 
    );
    
  }
}
