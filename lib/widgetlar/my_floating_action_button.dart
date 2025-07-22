import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';
class MyFloatingActionButton extends StatelessWidget {
  final List<GridYapisi> grids;
   MyFloatingActionButton({super.key, required this.grids});
   final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
     onPressed: () {
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             title: Text('Yeni Not Ekle'),
             content: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 TextField(
                   decoration: InputDecoration(hintText: 'Not başlığı'),
                   controller: textEditingController,
                 ),
                 SizedBox(height: 10),
                 TextField(
                   decoration: InputDecoration(hintText: 'Not içeriği'),
                 )
               ],
             ),
             actions: [
               TextButton(
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
                 child: Text('İptal')
               ),
               TextButton(
                 onPressed: () {
                   grids.add(GridYapisi(
                     id: grids.length + 1,
                     title: textEditingController.text,
                     description: 'Yeni not içeriği',
                   ));
                   Navigator.of(context).pop();
                 },
                 child: Text('Ekle')
               )
             ]
           );
         }
       );
     }
     );
  }
}