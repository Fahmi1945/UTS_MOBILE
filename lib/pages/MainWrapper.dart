// lib/pages/main_wrapper.dart
import 'package:flutter/material.dart';
// Import halaman-halaman yang akan kita tampilkan
import 'HomePage.dart';
import 'ProfilPage.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Variabel untuk melacak halaman (tab) yang sedang aktif
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  // Ini sesuai dengan urutan ikon di BottomNavigationBar
  static final List<Widget> _pages = <Widget>[
    
    // Halaman 1 (Indeks 0): Beranda
    const HomePage(), 

    // Halaman 2 (Indeks 1): Menu (Placeholder)
    // Ini adalah halaman dummy statis untuk memenuhi desain
    Scaffold(
      appBar: AppBar(title: Text("Menu")),
      body: Center(
        child: Text("Halaman Menu", style: TextStyle(fontSize: 20)),
      ),
    ),

    // Halaman 3 (Indeks 2): Pesanan (Placeholder)
    // Ini juga halaman dummy statis
    Scaffold(
      appBar: AppBar(title: Text("Pesanan")),
      body: Center(
        child: Text("Halaman Pesanan", style: TextStyle(fontSize: 20)),
      ),
    ),

    // Halaman 4 (Indeks 3): Profil
    const ProfilePage(),
  ];

  // Fungsi ini akan dipanggil ketika user menekan salah satu ikon
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update state untuk ganti halaman
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body akan menampilkan halaman dari List _pages
      // berdasarkan _selectedIndex yang sedang aktif
      body: _pages.elementAt(_selectedIndex),
      
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        // Pengaturan ini mengambil style dari tema di main.dart
        currentIndex: _selectedIndex, // Ikon mana yang sedang aktif
        onTap: _onItemTapped, // Fungsi yang dipanggil saat ikon di-tap
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}