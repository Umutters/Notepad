import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umuttersnotlar/Services/background_themes.dart';
import 'package:umuttersnotlar/sayfalar/entry_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Not Uygulaması',
            
            // ✅ Detaylı açık tema
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              cardColor: Colors.white,
              dividerColor: Colors.grey[300],
              
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 1,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              textTheme: TextTheme(
                titleLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
                bodyMedium: TextStyle(color: Colors.grey[700], fontSize: 14),
                bodySmall: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              
              iconTheme: IconThemeData(color: Colors.black),
              
              drawerTheme: DrawerThemeData(
                backgroundColor: Colors.white,
              ),
              
              dialogTheme: DialogThemeData(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                contentTextStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
              
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                foregroundColor: Colors.white,
              ),
              
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
              ),
              
            ),
            
            // ✅ Detaylı koyu tema
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.grey[900],
              cardColor: Colors.grey[800],
              dividerColor: Colors.grey[600],
              
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[850],
                foregroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 1,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              textTheme: TextTheme(
                titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
                bodyMedium: TextStyle(color: Colors.grey[300], fontSize: 14),
                bodySmall: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              
              iconTheme: IconThemeData(color: Colors.white),
              
              drawerTheme: DrawerThemeData(
                backgroundColor: Colors.grey[850],
              ),
              
              dialogTheme: DialogThemeData(
                backgroundColor: Colors.grey[800],
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                contentTextStyle: TextStyle(color: Colors.white, fontSize: 14),
              ),
              
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
              
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                ),
              ),
              
            ),
            
            themeMode: themeProvider.isDarkMode 
                ? ThemeMode.dark 
                : ThemeMode.light,
            home:  EntryPage(),
          );
        },
      ),
    );
  }
}





