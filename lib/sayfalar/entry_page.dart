import 'package:flutter/material.dart';
import 'package:umuttersnotlar/widgetlar/appbar/drawer.dart';
import 'package:umuttersnotlar/widgetlar/appbar/not_uygulama_appbar.dart';
import 'package:umuttersnotlar/widgetlar/cards/grid_view_card.dart';
import 'package:umuttersnotlar/widgetlar/widgets/my_floating_action_button.dart';
import 'package:umuttersnotlar/theme/renkler.dart';
import 'package:umuttersnotlar/controller/controller.dart';

class EntryPage extends StatefulWidget {
   EntryPage({super.key});
  final List<String> dropdownItems = [
    'Tarihe Göre Sirala',
    'Değişim Tarihine Göre Sirala',
    'Başliğa Göre Sirala',
  ];
  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  bool isBrandClicked = false;
  bool isButtonClicked = false;
  late String dropDownValue;
  late Controller controller; // Controller instance
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.dropdownItems.first;
    controller = Controller(); // Controller'ı başlat
  }

  @override
  void dispose() {
    controller.dispose(); // Controller'ı temizle
    textEditingController.dispose();
    super.dispose();
  }

  // Controller'dan sıralama fonksiyonunu kullanan metod
  void sort(String value) {
    setState(() {
      controller.sort(value);
      dropDownValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    IconData? icon = isButtonClicked ? Icons.arrow_upward : Icons.arrow_downward;
    return Scaffold(
      backgroundColor: Renkler.scaffoldColor,
      appBar: NotUygulamaAppBar(
        isBrandClicked: isBrandClicked,
        onBrandToggle: () {
          setState(() {
            isBrandClicked = !isBrandClicked;
          });
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    //tersine çevir
                    isButtonClicked = !isButtonClicked;
                    controller.reverseGrids(); // Controller'dan tersine çevir
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
                    sort(value!);
                  },
                ),
         )
            ]
          ,),
         GridViewCard(
           grids: controller.grids, // Controller'dan grids al
           onGridUpdate: (updatedGrid, index) {
             setState(() {
               controller.updateGrid(updatedGrid, index);
                // Controller ile güncelle
             });
           },
            onGridDelete: (index) {
              setState(() {
                controller.removeGrid(index);
              });
            },
         ),
         ]
      ),
     floatingActionButton: MyFloatingActionButton(
       textEditingController: textEditingController,
       onAdd: (title) {
         setState(() {
           controller.addGrid(title); // Controller ile yeni not ekle
         });
       },
     ),
     drawer:isBrandClicked
         ? null
         :  MyDrawer(),
   );
 }
}