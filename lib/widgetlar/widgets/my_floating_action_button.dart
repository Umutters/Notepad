import 'package:flutter/material.dart';
import 'package:umuttersnotlar/Services/theme_helper.dart';

class MyFloatingActionButton extends StatelessWidget {
  final void Function(String title) onAdd;
  final TextEditingController textEditingController;
  const MyFloatingActionButton({super.key, required this.onAdd, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ThemeHelper.getFloatingActionButtonColor(context),
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
      child:  Icon(Icons.add,color: Theme.of(context).floatingActionButtonTheme.foregroundColor),
    );
  }
}

