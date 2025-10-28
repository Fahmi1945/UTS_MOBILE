// lib/pages/main_wrapper.dart
import 'package:flutter/material.dart';
// Kita akan import halaman-halamannya nanti
import 'HomePage.dart';
import 'CartPage.dart';
import 'FavoritePage.dart';
import 'ProfilePage.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Variabel untuk melacak halaman (tab) yang sedang aktif
  int _selectedIndex = 0;

  // --- DAFTAR HALAMAN ---
  // Ini adalah daftar halaman yang akan ditampilkan oleh Bottom Nav Bar
  // Halaman ke-2 (DetailPage) tidak ada di sini karena dipanggil dari HomePage
  static final List<Widget> _pages = <Widget>[
    // Halaman 1: Home (Dashboard)
    // TODO: Ganti Placeholder() dengan HomePage() setelah file-nya dibuat
    const HomePage(),

    // Halaman 2: Cart (Keranjang)
    // TODO: Ganti Placeholder() dengan CartPage()
    const CartPage(),

    // Halaman 3: Favorite
    // TODO: Ganti Placeholder() dengan FavoritePage()
    const FavoritePage(),

    // Halaman 4: Profile
    // TODO: Ganti Placeholder() dengan ProfilePage()
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

      // --- BOTTOM NAVIGATION BAR ---
      // (Sesuai dengan 4 ikon di desain Anda)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Ikon mana yang sedang aktif
        onTap: _onItemTapped, // Fungsi yang dipanggil saat ikon di-tap
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
