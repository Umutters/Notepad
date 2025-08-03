import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:umuttersnotlar/sayfalar/entry_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        hoverColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('tr', 'TR'), // Türkçe
        Locale('en', 'US'), // İngilizce
      ],
      home:  EntryPage(),
    );
  }
}


  

