// lib/pages/home_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:projek_flutter/main.dart';
import 'DetailPage.dart';

import '../models/CoffeModel.dart'; // Import model
// import 'detail_page.dart'; // Nanti kita uncomment ini

// Ambil warna dari main.dart (atau definisikan ulang di sini jika perlu)
const Color kPrimaryGreen = Color(0xFF1BAE76);
const Color kGreyColor = Color(0xFF808080);
const Color kScaffoldBackground = Color(0xFFEFEFEF);
const Color kWhiteColor = Color(0xFFFFFFFF);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Coffee>> _coffeeData;
  final String apiUrl =
      "https://68fe947f7c700772bb1408b8.mockapi.io/coffee"; // GANTI URL INI
  String _selectedFilter = "Coffee";
  void initState() {
    super.initState();
    _coffeeData = _fetchCoffeeData();
  }

  Future<List<Coffee>> _fetchCoffeeData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Coffee.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data dari API');
    }
  }

  // --- UI BUILD METHOD (Struktur Baru) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Latar belakang utama kita buat hijau
      backgroundColor: kPrimaryGreen,

      // 2. Hapus AppBar standar
      // appBar: null, (Tidak perlu AppBar)

      // 3. Gunakan SafeArea agar konten tidak tertutup status bar
      body: SafeArea(
        bottom: false, // SafeArea hanya untuk atas
        child: Column(
          children: [
            // --- BAGIAN 1: HEADER HIJAU KUSTOM ---
            _buildHeaderContent(context),

            // --- BAGIAN 2: KONTEN PUTIH YANG BISA SCROLL ---
            Expanded(
              child: Container(
                // Ini adalah container putih dengan sudut melengkung
                decoration: const BoxDecoration(
                  color: kScaffoldBackground, // Warna abu-abu pudar
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.0), // Sudut melengkung di atas
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Banner Promo
                      _buildBanner(),

                      // Filter Kategori
                      _buildFilterChips(),

                      // Grid Produk
                      _buildProductGrid(),

                      // Padding di bawah agar tidak terpotong BottomNav
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER (Pemecah UI) ---

  // WIDGET BARU: Isi dari header hijau
  Widget _buildHeaderContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Baris 1: Judul Kafe dan Ikon Profil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Green Cafe",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Jl. Gajayana Malang",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kWhiteColor.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.account_circle, size: 40, color: kWhiteColor),
            ],
          ),
          const SizedBox(height: 16),

          // Baris 2: Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search coffee",
              hintStyle: TextStyle(color: kGreyColor),
              prefixIcon: const Icon(Icons.search, color: kGreyColor),
              filled: true,
              fillColor: kWhiteColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.0,
              ), // Atur tinggi
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    // Pastikan gambar banner Anda ada di 'assets/images/banner.png'
    // Saya ganti nama filenya agar lebih generik
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          'assets/images/banner.png', // GANTI NAMA FILE INI
          width: double.infinity,
          height: 125,
          fit: BoxFit.cover,
          // Error builder jika file tidak ditemukan
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 125,
              color: Colors.grey[300],
              child: const Center(
                child: Text("Gagal memuat banner\n(assets/images/banner.png)"),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Beri jarak
        children: [
          _buildFilterChip("Coffee", isSelected: _selectedFilter == "Coffee"),
          _buildFilterChip(
            "Non Coffee",
            isSelected: _selectedFilter == "Non Coffee",
          ),
          _buildFilterChip("Food", isSelected: _selectedFilter == "Food"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isSelected}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Text(label),
          labelStyle: TextStyle(
            color: isSelected ? kWhiteColor : kBlackColor,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: kWhiteColor, // Tombol non-aktif
          selectedColor: kPrimaryGreen, // Tombol aktif
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedFilter = label;
              // TODO: Di masa depan, ini akan memuat ulang API
              // if (label == "Coffee") _coffeeData = _fetchCoffeeData();
              // else _coffeeData = ... (memuat API Non Coffee, dll)
            });
          },
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    // Kita tampilkan grid hanya jika filter "Coffee" yang aktif
    if (_selectedFilter != "Coffee") {
      return Container(
        height: 200,
        child: const Center(child: Text("Data untuk filter ini belum ada.")),
      );
    }

    // FutureBuilder untuk menangani data API
    return FutureBuilder<List<Coffee>>(
      future: _coffeeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.hasData) {
          final List<Coffee> coffees = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.65, // Disesuaikan agar lebih mirip desain
            ),
            itemCount: coffees.length,
            itemBuilder: (context, index) {
              return _buildProductCard(coffees[index]);
            },
          );
        }
        return const Center(child: Text("Tidak ada data kopi"));
      },
    );
  }

  Widget _buildProductCard(Coffee coffee) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke DetailPage dengan mengirim data 'coffee'
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(coffee: coffee),
          ),
        );
      },
      child: Card(
        // Tema kartu (rounded 16.0) sudah diatur di main.dart
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- GAMBAR ---
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              child: Image.network(
                coffee.imageUrl,
                height: 120, // Tinggi gambar tetap 120
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),

            // --- NAMA & HARGA ---
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8), // Atur padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${coffee.price.toStringAsFixed(0)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            // --- KITA HAPUS 'SPACER' DARI SINI ---
            // const Spacer(), // HAPUS SPACER INI

            // --- IKON FAVORIT & ADD (INI SOLUSINYA) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12), // Atur padding
              child: Row(
                // <-- Gunakan ROW agar ikon ke samping
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // <-- Hati di kiri, Plus di kanan
                children: [
                  // Tombol Hati (Favorite)
                  Icon(
                    Icons
                        .favorite_border, // Ganti jadi Icons.favorite jika di-klik
                    color: kGreyColor,
                    size: 24,
                  ),
                  // Tombol Add (+)
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: kPrimaryGreen,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(Icons.add, color: kWhiteColor, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
