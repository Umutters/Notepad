import 'package:flutter/material.dart';
import 'package:umuttersnotlar/Services/theme_helper.dart';
//import 'package:umuttersnotlar/theme/renkler.dart';

class NotUygulamaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBrandClicked;
  final VoidCallback? onBrandToggle;
  final bool isButtonClicked;
  final ValueChanged<String?>? onSearch;
  final Function? onThemeToggle;
  const NotUygulamaAppBar({
    super.key, 
    required this.onBrandToggle,
    required this.isBrandClicked, 
    required this.isButtonClicked,
    required this.onSearch,
    required this.onThemeToggle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    // Ortak renkler ve stiller
     TextStyle textStyle = TextStyle(fontSize: 16, color: ThemeHelper.getTextColor(context));
    
    // Ortak callback
    void handleToggle() => onBrandToggle?.call();
    
    return isBrandClicked 
      ? _buildSearchAppBar(handleToggle, textStyle, context)
      : _buildNormalAppBar(context, handleToggle);
  }
  
  // Arama modu AppBar'ı
  AppBar _buildSearchAppBar(VoidCallback onToggle, TextStyle textStyle, BuildContext context) {
    return AppBar(
      backgroundColor: ThemeHelper.getAppBarColor(context),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onToggle,
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Ara...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: ThemeHelper.getSearchFieldColor(context),
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          prefixIcon: const Icon(Icons.search),
        ),
        style: textStyle,
        textAlign: TextAlign.left,
      ),
    );
  }
  
  // Normal mod AppBar'ı
  AppBar _buildNormalAppBar(BuildContext context, VoidCallback onToggle) {
    return AppBar(
      backgroundColor: ThemeHelper.getAppBarColor(context),
      title:  Text('Not Uygulaması',style: TextStyle(color: ThemeHelper.getTextColor(context)),),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onToggle,
          icon: Icon(Icons.search, color: ThemeHelper.getIconColor(context))
        ),
      ],
      leading: Builder(
        builder: (context) => IconButton(
          icon:  Icon(Icons.menu, color: ThemeHelper.getIconColor(context)),
          onPressed: () {
            Scaffold.maybeOf(context)?.openDrawer();
          },
        ),
      ),
    );
  }
}