import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umuttersnotlar/Services/background_themes.dart';
import 'package:umuttersnotlar/widgetlar/appbar/not_uygulama_appbar.dart';
import 'package:umuttersnotlar/widgetlar/cards/grid_view_card.dart';
import 'package:umuttersnotlar/widgetlar/widgets/drawer.dart';
import 'package:umuttersnotlar/controller/controller.dart';
import 'package:umuttersnotlar/Services/theme_helper.dart';
import 'package:umuttersnotlar/widgetlar/widgets/my_floating_action_button.dart';

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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          // ✅ Theme'dan otomatik al
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          
          appBar: NotUygulamaAppBar(
            onThemeToggle: () => controller.toggleTheme(),
            isBrandClicked: isBrandClicked,
            isButtonClicked: isButtonClicked,
            onBrandToggle: toggleAppBar,
            onSearch: (query) => controller.searchGrids(query ?? ''),
          ),

          drawer:  NotUygulamaDrawer(onThemeToggle: () => controller.toggleTheme(),),

          body: Column(
            children: [
              if (!isBrandClicked)
                Container(
                  // ✅ Theme'dan otomatik al
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: dropDownValue,
                          // ✅ Theme'dan otomatik al
                          dropdownColor: ThemeHelper.getDropDownColor(context),
                          style: Theme.of(context).textTheme.bodyLarge,
                          items: widget.dropdownItems.map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              // ✅ Theme'dan otomatik al
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )).toList(),
                          onChanged: (value) => sort(value!),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => controller.reverseGrids()),
                        icon: Icon(
                          Icons.swap_vert,
                          // ✅ Theme'dan otomatik al
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              
              GridViewCard(
                grids: controller.grids,
                onGridUpdate: (updatedGrid, index) => controller.updateGrid(updatedGrid, index),
                onGridDelete: (index) async => await controller.removeGrid(index),
                onColorChange: (index, color) async => await controller.updateGrid(controller.grids[index], index),
              ),
            ],
          ),
          
          // ✅ Theme'dan otomatik FAB
          floatingActionButton: MyFloatingActionButton(onAdd: (title) {
            // Yeni not ekle
            controller.addGrid(textEditingController.text, context);
            textEditingController.clear();
          }, textEditingController: textEditingController)
        );
      }
    );
  }
}