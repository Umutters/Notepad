import 'package:flutter/material.dart';

class NotUygulamaAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isBrandClicked;
 const NotUygulamaAppBar({super.key, required this.isBrandClicked});

  @override
  State<NotUygulamaAppBar> createState() => _NotUygulamaAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _NotUygulamaAppBarState extends State<NotUygulamaAppBar> {
  late bool _isBrandClicked;
  @override
  void initState() {
    _isBrandClicked = widget.isBrandClicked;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _isBrandClicked
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
              
              leading: IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  setState(() {
                  
                    _isBrandClicked = widget.isBrandClicked;
                  });
                },
              ),
            )
          : AppBar(
              toolbarHeight: 60,
              title: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Umutters Notlar',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBrandClicked = !_isBrandClicked;
                      });
                    },
                    child: Image.asset(
                      'assets/images/Berserk-Logo.jpg',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported,
                            color: Colors.red);
                      },
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // Action to perform when the menu button is pressed
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            );
  }
}