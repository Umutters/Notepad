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
  late Controller controller;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.dropdownItems.first;
    controller = Controller();
    controller.addListener(() {
      setState(() {
        // Controller değiştiğinde UI'yı güncelle
      });
    });
    controller.loadGrids(); // Başlangıçta verileri yükle
  }

  void sort(String value) {
    setState(() {
      dropDownValue = value;
      controller.sortGrids(value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  // AppBar değiştirme fonksiyonu
  void toggleAppBar() {
    setState(() {
      isBrandClicked = !isBrandClicked;
      isButtonClicked = !isButtonClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.scaffoldColor,
      appBar: NotUygulamaAppBar(
        isBrandClicked: isBrandClicked,
        isButtonClicked: isButtonClicked,
        onBrandToggle: toggleAppBar,
        onSearch: (query) {
          controller.searchGrids(query??'');
        },
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Dropdown sadece normal modda görünsün
          if (!isBrandClicked)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                ),
                // Reverse butonu
                IconButton(
                  onPressed: () {
                    setState(() {
                      controller.reverseGrids();
                    });
                  },
                  icon: const Icon(Icons.swap_vert),
                  tooltip: 'Listeyi Ters Çevir',
                ),
              ],
            ),
          GridViewCard(
            grids: controller.grids,
            onGridUpdate: (updatedGrid, index) {
              controller.updateGrid(updatedGrid, index);
            },
            onGridDelete: (index) async{
              await controller.removeGrid(index);
            },
            onColorChange: (index, color)async {
              
             await controller.updateGrid(controller.grids[index], index);
            },
          ),
        ],
      ),
      floatingActionButton: MyFloatingActionButton(
        textEditingController: textEditingController,
        onAdd: (title) {
          controller.addGrid(title);
        },
      ),
    );
  }
}