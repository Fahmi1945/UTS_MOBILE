// lib/pages/home_page.dart
import 'dart:convert'; // Diperlukan untuk json.decode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Diperlukan untuk rootBundle (membaca file aset)

// Import Model dan Halaman Detail
import '../models/CoffeModel.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variabel untuk menampung data kopi dari JSON
  // Kita gunakan 'Future' karena proses membaca file butuh waktu (asynchronous)
  late Future<List<Coffee>> _coffeeData;

  @override
  void initState() {
    super.initState();
    // Saat halaman pertama kali dibuka, panggil fungsi untuk memuat data JSON
    _coffeeData = _loadCoffeeData();
  }

  // --- FUNGSI UNTUK MEMUAT DATA DUMMY JSON ---
  // Sesuai kriteria UTS [cite: 19]
  Future<List<Coffee>> _loadCoffeeData() async {
    // 1. Membaca file JSON dari folder assets
    final String jsonString = await rootBundle.loadString(
      'assets/json/CoffeData.json',
    );

    // 2. Mengubah string JSON menjadi List<dynamic>
    final List<dynamic> jsonList = json.decode(jsonString);

    // 3. Mengubah setiap item di list menjadi objek Coffee (sesuai model)
    // dan mengembalikannya sebagai List<Coffee>
    return jsonList.map((json) => Coffee.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Ini adalah Scaffold dan AppBar dari KODE ANDA sebelumnya
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Selamat pagi, Budi!", // (Sesuai kode Anda)
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black54,
              size: 28,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      // Ini adalah Body dari KODE ANDA sebelumnya
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar (Kode Anda)
              _buildSearchBar(),
              const SizedBox(height: 24),

              // 2. Hero Banner (Kode Anda)
              _buildHeroBanner(),
              const SizedBox(height: 24),

              // 3. Kategori Cepat (Kode Anda)
              _buildQuickCategories(),
              const SizedBox(height: 24),

              // 4. Rekomendasi / Paling Laris
              Text(
                "Paling Laris 🔥",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // --- PERUBAHAN UTAMA DI SINI ---
              // Kita ganti ListView statis Anda dengan FutureBuilder
              _buildRecommendationList(),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER (SEMUA DARI KODE ANDA) ---

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Cari kopi favoritmu...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  Widget _buildHeroBanner() {
    // Kita ganti Image.network menjadi Image.asset jika gambar banner ada di lokal
    // Jika tidak, biarkan NetworkImage tidak apa-apa untuk banner.
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.brown[400],
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
          image: NetworkImage(
            // Biarkan ini jika hanya untuk banner (non-data)
            'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?fit=crop&w=800&q=80',
          ),
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

  // --- WIDGET DAFTAR REKOMENDASI (SUDAH DIMODIFIKASI) ---

  Widget _buildRecommendationList() {
    return SizedBox(
      height: 230, // Tentukan tinggi agar list horizontal bisa render
      child: FutureBuilder<List<Coffee>>(
        future: _coffeeData, // Sumber datanya dari _coffeeData
        builder: (context, snapshot) {
          // 1. Saat data sedang di-load
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Jika terjadi error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // 3. Jika data berhasil di-load
          if (snapshot.hasData) {
            final List<Coffee> coffees = snapshot.data!;

            // Kita gunakan ListView.builder untuk membuat list dari data
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffees.length, // Jumlah item sesuai data JSON
              itemBuilder: (context, index) {
                final coffee = coffees[index];

                // --- IMPLEMENTASI NAVIGASI ---
                // Bungkus Card dengan GestureDetector agar bisa di-klik [cite: 23]
                return GestureDetector(
                  onTap: () {
                    // Aksi pindah halaman ke DetailPage [cite: 16]
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(coffee: coffee),
                      ),
                    );
                  },
                  child: _buildRecommendationCard(
                    coffee.nama,
                    coffee.harga,
                    coffee.gambarUrl, // Path gambar dari JSON (lokal)
                  ),
                );
              },
            );
          }
          // 4. Jika data kosong
          return const Center(child: Text("Tidak ada data"));
        },
      ),
    );
  }

  // Card individual (Hampir sama dengan kode Anda, hanya ganti Image.network)
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
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15.0),
            ),
            // --- PERUBAHAN: Gunakan Image.asset untuk data lokal [cite: 19] ---
            // --- PERUBAHAN: Gunakan Image.network untuk URL internet ---
            child: Image.network(
              imageUrl, // Misal: 'https://images.unsplash.com/...'
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,

              // (Pro Tip) Tambahkan ini agar ada loading indicator
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null)
                      return child; // Gambar selesai di-load
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
              // (Pro Tip) Tampilkan icon error jika URL gagal dimuat
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                );
              },
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
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
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
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
  }
}
