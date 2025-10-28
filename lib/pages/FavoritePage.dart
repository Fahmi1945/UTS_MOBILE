// lib/pages/favorite_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Ambil warna dari main.dart
const Color kPrimaryGreen = Color(0xFF1BAE76);
const Color kGreyColor = Color(0xFF808080);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kScaffoldBackground = Color(0xFFEFEFEF);

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // --- STATE FAVORIT ---
  // Untuk saat ini, kita buat list-nya kosong
  final List<dynamic> _favoriteItems = []; // Nanti ini akan diisi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(
        title: const Text("Menu Favorit"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      // 2. Body
      body: _favoriteItems.isEmpty
          ? _buildEmptyFavorites() // Tampilkan ini jika kosong
          : _buildFavoritesList(), // Tampilkan ini jika ada isinya
    );
  }

  // --- WIDGET UNTUK TAMPILAN KOSONG ---
  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border, // Ikon hati
            size: 100,
            color: kGreyColor.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            "Anda belum punya favorit",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tekan ikon ❤️ pada menu untuk menyimpannya.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kGreyColor,
                ),
            textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  // --- WIDGET UNTUK TAMPILAN JIKA ADA ISI ---
  Widget _buildFavoritesList() {
    // (NANTI KITA ISI)
    // Ini akan berisi GridView dari kopi yang sudah di-love
    return const Center(
      child: Text("Ada item favorit!"), // Placeholder
    );
  }
}