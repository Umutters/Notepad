import 'package:flutter/material.dart';
import 'package:umuttersnotlar/theme/renkler.dart';

class MyFloatingActionButton extends StatelessWidget {
  final void Function(String title) onAdd;
  final TextEditingController textEditingController;
  const MyFloatingActionButton({super.key, required this.onAdd, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Renkler.scaffoldColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Yeni Not Ekle'),
              content: TextField(
                controller: textEditingController,
                decoration: InputDecoration(hintText: 'Başlık girin'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('İptal'),
                ),
                TextButton(
                  onPressed: () {
                    final title = textEditingController.text;
                    if (title.isNotEmpty) {
                      onAdd(title);
                    }
                    textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Ekle'),
                ),
              ],
            );
          }
        );
      },
      child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
    );
  }
}

