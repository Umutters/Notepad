import 'package:flutter/material.dart';


class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? selectedColor;
  final ValueChanged<Color>? onColorChanged;
  final TextEditingController? textController;
  final Function(String format, bool isActive)? onFormatChanged; // ✅ Format callback

   MyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor,
    this.onColorChanged,
    this.textController,
    this.onFormatChanged,
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
            IconButton(
              icon: Icon(Icons.format_bold),
              tooltip: 'Kalın',
              onPressed: () {
                _toggleFormat('bold'); // ✅ Toggle format
              },
            ),
            IconButton(
              icon: Icon(Icons.format_italic),
              tooltip: 'İtalik',
              onPressed: () {
                _toggleFormat('italic');
              },
            ),
            IconButton(
              icon: Icon(Icons.format_size),
              tooltip: 'Büyüt',
              onPressed: () {
                _formatSelectedText('uppercase'); // Sadece text transform
              },
            ),
            IconButton(
              icon: Icon(Icons.color_lens),
              tooltip: 'Renk Seç',
              onPressed: () {
                _showColorPicker(context);
              },
            ),
            //altına çizgi ekle
            IconButton(
              icon: Icon(Icons.format_underline),
              tooltip: 'Altı Çizili',
              onPressed: () {
                _toggleFormat('underline'); // ✅ Altı çizili format
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Format toggle (TextStyle değiştir)
  void _toggleFormat(String format) {
    if (onFormatChanged != null) {
      onFormatChanged!(format, true); // Parent'a bildir
    }
  }

  // ✅ Sadece text transformation (büyük/küçük harf)
  void _formatSelectedText(String format) {
    if (textController == null) return;
    
    final selection = textController!.selection;
    final text = textController!.text;
    
    if (selection.start == selection.end) return;
    
    String selectedText = text.substring(selection.start, selection.end);
    String formattedText;
    
    switch (format) {
      case 'uppercase':
        formattedText = selectedText.toUpperCase();
        break;
      case 'lowercase':
        formattedText = selectedText.toLowerCase();
        break;
      default:
        formattedText = selectedText;
    }
    
    final newText = text.replaceRange(selection.start, selection.end, formattedText);
    textController!.text = newText;
    
    textController!.selection = TextSelection.collapsed(
      offset: selection.start + formattedText.length,
    );
  }

  // ✅ Renk seçici (StatefulBuilder ile)
  void _showColorPicker(BuildContext context) {
    if (onColorChanged == null) return;
    
    Color tempColor = selectedColor ?? Colors.black;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // ✅ StatefulBuilder ekle
          builder: (context, setState) {
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
                        setState(() {
                          tempColor = _colors[index]; // ✅ Dialog içinde güncelle
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colors[index],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: tempColor == _colors[index] 
                                ? Colors.black 
                                : Colors.grey,
                            width: tempColor == _colors[index] ? 3 : 1,
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
      },
    );
  }

  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.grey,
  ];
}


