  import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void showColorPicker({required context, required grid, required ValueChanged<Color> onColorSelected}) {
    Color tempColor = grid.cardColor ?? Colors.white;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Renk Seç"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (color) {
              tempColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
             onColorSelected(tempColor);
            },
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }