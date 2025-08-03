import 'package:flutter/material.dart';


class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? selectedColor;
  final ValueChanged<Color>? onColorChanged;
  final TextEditingController? textController; // ✅ TextEditingController kullan
  
     MyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor,
    this.onColorChanged,
    this.textController, // ✅ TextField controller'ı
  });

  @override
  Widget build(BuildContext context) {
    return _buildBottomBar(context);
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ✅ Seçili metni büyük harfe çevir
            IconButton(
              icon: Icon(Icons.format_size),
              onPressed: () {
                _formatSelectedText('uppercase');
              },
            ),
            // ✅ Seçili metni küçük harfe çevir
            IconButton(
              icon: Icon(Icons.text_fields),
              onPressed: () {
                _formatSelectedText('lowercase');
              },
            ),
            // ✅ Seçili metni kalın yap (** ile)
            IconButton(
              icon: Icon(Icons.format_bold),
              onPressed: () {
                _formatSelectedText('bold');
              },
            ),
            // ✅ Seçili metni italik yap (* ile)
            IconButton(
              icon: Icon(Icons.format_italic),
              onPressed: () {
                _formatSelectedText('italic');
              },
            ),
            // ✅ Renk seçici
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {
                _showColorPicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Seçili metni formatla
  void _formatSelectedText(String format) {
    if (textController == null) return;
    
    final selection = textController!.selection;
    final text = textController!.text;
    
    if (selection.start == selection.end) return; // Seçim yoksa çık
    
    String selectedText = text.substring(selection.start, selection.end);
    String formattedText;
    
    switch (format) {
      case 'uppercase':
        formattedText = selectedText.toUpperCase();
        break;
      case 'lowercase':
        formattedText = selectedText.toLowerCase();
        break;
      case 'bold':
        formattedText = '**$selectedText**'; // Markdown bold
        break;
      case 'italic':
        formattedText = '*$selectedText*'; // Markdown italic
        break;
      default:
        formattedText = selectedText;
    }
    
    // Metni güncelle
    final newText = text.replaceRange(selection.start, selection.end, formattedText);
    textController!.text = newText;
    
    // Cursor pozisyonunu ayarla
    textController!.selection = TextSelection.collapsed(
      offset: selection.start + formattedText.length,
    );
  }

  // ✅ Renk seçici dialog
  void _showColorPicker(BuildContext context) {
    if (onColorChanged == null) return;
    
    Color tempColor = selectedColor ?? Colors.black;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yazı Rengi Seç'),
          content: SizedBox(
            width: 300,
            height: 200,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    tempColor = _colors[index];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _colors[index],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: tempColor == _colors[index] 
                            ? Colors.black 
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                onColorChanged!(tempColor);
              },
            ),
          ],
        );
      },
    );
  }

  final List<Color> _colors = [
   Colors.red,
   Colors.green,
   Colors.blue,
   Colors.yellow,
   Colors.orange,
   Colors.purple,
   Colors.brown,
   Colors.grey,
   Colors.black,
   Colors.white,
 ]; // ✅ Renk paleti

}


