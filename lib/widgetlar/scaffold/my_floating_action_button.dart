import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/renkler.dart';

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
                decoration: InputDecoration(hintText: 'Not başlığı'),
                controller: textEditingController,
                
              ),
              actions: [
                NotesTextButton(),
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
      child:const Icon(Icons.add,color: Colors.white,),
    );
  }
}

class NotesTextButton extends StatelessWidget {
  const NotesTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('İptal'),
    );
  }
}