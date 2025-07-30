import 'package:flutter/material.dart';

//import 'package:flutter_quill/flutter_quill.dart';
import 'package:umuttersnotlar/sayfalar/entry_page.dart';




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
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  EntryPage(),
    );
  }
}


  

