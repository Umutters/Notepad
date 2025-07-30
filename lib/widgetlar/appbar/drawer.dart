import 'package:flutter/material.dart';
import 'package:umuttersnotlar/classlar/renkler.dart';
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Renkler.scaffoldColor,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item tap
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle item tap
            },
          ),
        ],
      ),
    );
  }
}