import 'package:flutter/material.dart';


class MyFloatingActionButton extends StatelessWidget {
  final void Function(String title) onAdd;
  const MyFloatingActionButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Yeni Not Ekle'),
              content: TextField(
                decoration: InputDecoration(hintText: 'Not başlığı'),
                controller: textEditingController,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('İptal'),
                ),
                TextButton(
                  onPressed: () {
                    onAdd(textEditingController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Ekle'),
                ),
              ],
            );
          }
        );
      },
    );
  }
}