import 'package:flutter/material.dart';
// 1. Import halaman wrapper yang akan kita buat nanti
import 'pages/MainWrapper.dart'; // Sesuaikan path jika perlu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      theme: ThemeData(
        // (Ini adalah kode TEMA Anda yang sudah benar dari file sebelumnya)
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      
      // 2. Arahkan 'home' ke MainWrapper, bukan HomeScreen lagi
      home: const MainWrapper(), 
      
      debugShowCheckedModeBanner: false,
    );
  }
}