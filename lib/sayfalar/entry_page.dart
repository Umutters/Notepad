
import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/grid_yapisi.dart';
import 'package:umuttersnotlar/widgetlar/appbar/not_uygulama_appbar.dart';
import 'package:umuttersnotlar/widgetlar/scaffold/grid_view_card.dart';
import 'package:umuttersnotlar/widgetlar/my_floating_action_button.dart';

class EntryPage extends StatefulWidget {
   EntryPage({super.key});
  final List<String> dropdownItems = [
    'Tarihe Göre Sırala',
    'Değişim Tarihine Göre Sırala',
    'Başlığa Göre Sırala',
  ];
  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  bool isBrandClicked = false;
  late String dropDownValue;
  late List<GridYapisi> grids;
  TextEditingController textEditingController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.dropdownItems.first;
    grids = [
      GridYapisi(id: 1, title: 'En Sevdiğim oyunlar', description: 'Description 1'),
      GridYapisi(id: 2, title: 'En Sevdiğim Filmler', description: 'Description 2'),
      GridYapisi(id: 3, title: 'En Sevdiğim Kitaplar', description: 'Description 3')
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotUygulamaAppBar(isBrandClicked: isBrandClicked),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_downward),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  value: dropDownValue,
                  items: widget.dropdownItems.map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  }
                ),
         )
            ]
          ,),
         GridViewCard(
           grids: grids,
           onGridUpdate: (updatedGrid, index) {
             setState(() {
               grids[index] = updatedGrid;
             });
           },
         ),
         ]
      ),
     floatingActionButton: MyFloatingActionButton(
       onAdd: (title) {
         setState(() {
           grids.add(GridYapisi(
             id: grids.length + 1,
             title: title,
             description: 'Yeni not içeriği',
              createdAt: DateTime.now(),
           ));
         });
       },
     ),
     backgroundColor: Colors.white,
   );
 }
}