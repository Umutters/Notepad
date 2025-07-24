
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
  bool isButtonClicked = false;
  late String dropDownValue;
  late List<GridYapisi> grids;
  TextEditingController textEditingController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.dropdownItems.first;
    grids = [];
  }
  @override
  Widget build(BuildContext context) {
     IconData? icon=isButtonClicked ? Icons.arrow_upward : Icons.arrow_downward;
    return Scaffold(
      appBar: NotUygulamaAppBar(isBrandClicked: isBrandClicked),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    //tersine çevir
                    isButtonClicked = !isButtonClicked;
                    grids = grids.reversed.toList();
                    icon = isButtonClicked ? Icons.arrow_upward : Icons.arrow_downward;
                  });
                }, icon: Icon(icon),
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
                      //tarihe göre sırala
                      if (value == 'Tarihe Göre Sırala') {
                        grids.sort((a, b) => (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
                      } else if (value == 'Değişim Tarihine Göre Sırala') {
                        grids.sort((a, b) => (a.updatedAt ?? DateTime(0)).compareTo(b.updatedAt ?? DateTime(0)));
                      } else if (value == 'Başlığa Göre Sırala') {
                        grids.sort((a, b) => a.title!.compareTo(b.title!));
                      }
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