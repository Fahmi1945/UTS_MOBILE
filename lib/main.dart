// main.dart
import 'package:flutter/material.dart';

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
        // Tentukan palet warna utama
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Latar belakang krem/putih pudar
        textTheme: const TextTheme(
          // Tentukan font default
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        // Tema untuk Bottom Nav Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed, // Penting agar semua item terlihat
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Melacak tab yang sedang aktif di Bottom Navigation Bar
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Di aplikasi nyata, ini akan menavigasi ke layar yang berbeda
    // switch(index) { ... }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APP BAR ---
      // AppBar dibuat transparan agar menyatu dengan body
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Sapaan di sebelah kiri
        title: const Text(
          "Selamat pagi, Budi!",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // Ikon notifikasi di sebelah kanan
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54, size: 28),
            onPressed: () {
              // Aksi saat ikon notifikasi di-tap
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- BODY ---
      // SingleChildScrollView agar layar bisa di-scroll jika kontennya panjang
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // 1. Search Bar
              _buildSearchBar(),
              const SizedBox(height: 24),

              // 2. Hero Banner / Promo
              _buildHeroBanner(),
              const SizedBox(height: 24),

              // 3. Kategori Cepat
              _buildQuickCategories(),
              const SizedBox(height: 24),

              // 4. Rekomendasi / Paling Laris
              Text(
                "Paling Laris 🔥",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              _buildRecommendationList(),
              
            ],
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

  // --- WIDGET HELPER ---
  // (Memecah UI menjadi fungsi-fungsi kecil agar lebih rapi)

  // Widget untuk Search Bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari kopi favoritmu...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none, // Tidak ada border
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  // Widget untuk Hero Banner
  Widget _buildHeroBanner() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.brown[400],
        borderRadius: BorderRadius.circular(20.0),
        // Placeholder untuk gambar promo
        image: const DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?fit=crop&w=800&q=80'),
          fit: BoxFit.cover,
          opacity: 0.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Promo Spesial Hari Ini",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
            ),
            Text(
              "Beli 1 Gratis 1 Es Kopi Susu",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Kategori Cepat (Horizontal)
  Widget _buildQuickCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryItem(Icons.coffee, "Kopi"),
        _buildCategoryItem(Icons.local_drink, "Non-Kopi"),
        _buildCategoryItem(Icons.bakery_dining, "Makanan"),
        _buildCategoryItem(Icons.grain, "Beans"),
      ],
    );
  }

  // Item individual untuk kategori
  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 30, color: Colors.brown[700]),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  // Widget untuk daftar rekomendasi (Horizontal Scroll)
  Widget _buildRecommendationList() {
    return SizedBox(
      height: 230, // Tentukan tinggi agar list horizontal bisa render
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Gunakan data dummy. Di aplikasi nyata, ini dari API.
          _buildRecommendationCard(
            "Caffè Latte",
            "Rp 28.000",
            "https://images.unsplash.com/photo-1511920170033-f8396924c348?fit=crop&w=400&q=80",
          ),
          _buildRecommendationCard(
            "Americano",
            "Rp 25.000",
            "https://images.unsplash.com/photo-1507133750040-6c8f57ddb2f4?fit=crop&w=400&q=80",
          ),
          _buildRecommendationCard(
            "Croissant",
            "Rp 22.000",
            "https://images.unsplash.com/photo-1530610476181-d83430b64dcd?fit=crop&w=400&q=80",
          ),
        ],
      ),
    );
  }

  // Card individual untuk item rekomendasi
  Widget _buildRecommendationCard(String name, String price, String imageUrl) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Detail Teks (Nama & Harga)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                // Baris untuk harga dan tombol tambah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.brown[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // Tombol Tambah (+)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 20),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}