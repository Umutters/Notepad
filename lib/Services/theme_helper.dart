import 'package:flutter/material.dart';
class ThemeHelper {

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  static Color getScaffoldColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[900]! : Colors.white;
  }
  static Color getAppBarColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[850]! : Colors.white;
  }
  static Color getIconColor(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }
  static Color getTextColor(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }
  static Color getDrawerBackgroundColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[850]! : Colors.white;
  }
  static Color getDrawerHeaderColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[800]! : Colors.blue[600]!;
  }
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).cardColor; 
  }
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
  }
  static Color getDropDownColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[700]! : Colors.grey[300]!;
  }
  static Color getSearchFieldColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[800]! : Colors.grey[200]!;
  }
  static Color getFloatingActionButtonColor(BuildContext context) {
    return Theme.of(context).floatingActionButtonTheme.backgroundColor ?? Colors.white;
  }
}