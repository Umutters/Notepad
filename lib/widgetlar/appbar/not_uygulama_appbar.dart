import 'package:flutter/material.dart';
import 'package:umuttersnotlar/theme/renkler.dart';

class NotUygulamaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBrandClicked;
  final VoidCallback? onBrandToggle;
  final bool isButtonClicked;
  final ValueChanged<String?>? onSearch;
  const NotUygulamaAppBar({
    super.key, 
    required this.onBrandToggle,
    required this.isBrandClicked, 
    required this.isButtonClicked,
    required this.onSearch,

  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    // Ortak renkler ve stiller
    const textStyle = TextStyle(fontSize: 16);
    
    // Ortak callback
    void handleToggle() => onBrandToggle?.call();
    
    return isBrandClicked 
      ? _buildSearchAppBar(handleToggle, textStyle)
      : _buildNormalAppBar(context, handleToggle);
  }
  
  // Arama modu AppBar'ı
  AppBar _buildSearchAppBar(VoidCallback onToggle, TextStyle textStyle) {
    return AppBar(
      backgroundColor: Renkler.scaffoldColor,
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
          fillColor: Colors.grey[200],
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
      backgroundColor: Renkler.scaffoldColor,
      title: const Text('Not Uygulaması',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onToggle,
          icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0))
        ),
      ],
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Scaffold.maybeOf(context)?.openDrawer();
          },
        ),
      ),
    );
  }
}