import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const MyBottomNavBar({super.key, required this.currentIndex, required this.onTap,required this.selectedColor,this.onColorChanged});
final Color? selectedColor;
final ValueChanged<Color>? onColorChanged;
@override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Color tempColor = selectedColor ?? Colors.green;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Renk Seç'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: tempColor,
                        onColorChanged: (Color color) {
                          tempColor = color;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onColorChanged != null) {
                            onColorChanged!(tempColor);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.color_lens),
          ),
          label: 'Yazı Renkleri',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_align_left),
          label: 'Notlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_fields),
          label: 'Metin',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_format),
          label: 'Biçim',
        ),
      ],
    );
  }
}