import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umuttersnotlar/Services/background_themes.dart';

class NotUygulamaDrawer extends StatelessWidget {
  const NotUygulamaDrawer({super.key, required this.onThemeToggle});
  final Function? onThemeToggle;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Drawer(
          backgroundColor: themeProvider.isDarkMode 
              ? Colors.grey[850] // ✅ Koyu tema drawer arka plan
              : Colors.white, // ✅ Açık tema drawer arka plan
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode 
                      ? Colors.grey[800] // ✅ Koyu tema header
                      : Colors.blue[600], // ✅ Açık tema header
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_alt,
                      size: 40,
                      color: Colors.white, // ✅ Her zaman beyaz ikon
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Not Uygulaması',
                      style: TextStyle(
                        color: Colors.white, // ✅ Her zaman beyaz yazı
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Notlarınızı organize edin',
                      style: TextStyle(
                        color: Colors.white70, // ✅ Şeffaf beyaz
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tema değiştir butonu
              ListTile(
                leading: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: themeProvider.isDarkMode ? Colors.orange : Colors.blue,
                ),
                title: Text(
                  themeProvider.isDarkMode ? 'Açık Moda Geç' : 'Koyu Moda Geç',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  themeProvider.toggleTheme(); // ✅ Provider'dan tema değiştir
                  Navigator.pop(context); // ✅ Drawer'ı kapat
                  
                  // ✅ Başarı mesajı göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        themeProvider.isDarkMode 
                            ? 'Koyu tema aktif' 
                            : 'Açık tema aktif',
                      ),
                      duration: Duration(seconds: 1),
                      backgroundColor: themeProvider.isDarkMode 
                          ? Colors.grey[700] 
                          : Colors.grey[800],
                    ),
                  );
                },
              ),
              
              Divider(
                color: themeProvider.isDarkMode 
                    ? Colors.grey[600] 
                    : Colors.grey[300],
              ),
              
              // Ana sayfa
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: themeProvider.isDarkMode ? Colors.blue[300] : Colors.blue[600],
                ),
                title: Text(
                  'Ana Sayfa',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              
              // Yeni not
              ListTile(
                leading: Icon(
                  Icons.add,
                  color: themeProvider.isDarkMode ? Colors.green[300] : Colors.green[600],
                ),
                title: Text(
                  'Yeni Not',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Yeni not oluştur
                },
              ),
              
              // Hakkında
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: themeProvider.isDarkMode ? Colors.purple[300] : Colors.purple[600],
                ),
                title: Text(
                  'Hakkında',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showAboutDialog(context, themeProvider);
                },
              ),
              
              SizedBox(height: 20),
              
              // Alt bilgi
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Divider(
                      color: themeProvider.isDarkMode 
                          ? Colors.grey[600] 
                          : Colors.grey[300],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.apps,
                          size: 16,
                          color: themeProvider.isDarkMode 
                              ? Colors.grey[400] 
                              : Colors.grey[600],
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Versiyon 1.0.0',
                          style: TextStyle(
                            color: themeProvider.isDarkMode 
                                ? Colors.grey[400] 
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ Hakkında dialog'u
  void _showAboutDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode 
              ? Colors.grey[800] 
              : Colors.white,
          title: Text(
            'Hakkında',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Not Uygulaması',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Versiyon: 1.0.0',
                style: TextStyle(
                  color: themeProvider.isDarkMode 
                      ? Colors.grey[300] 
                      : Colors.grey[700],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Geliştirici: Umut',
                style: TextStyle(
                  color: themeProvider.isDarkMode 
                      ? Colors.grey[300] 
                      : Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Bu uygulama notlarınızı düzenlemek ve organize etmek için geliştirilmiştir.',
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDarkMode 
                      ? Colors.grey[300] 
                      : Colors.grey[700],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Tamam',
                style: TextStyle(
                  color: themeProvider.isDarkMode 
                      ? Colors.blue[300] 
                      : Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}