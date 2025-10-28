// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Ambil warna dari main.dart
const Color kPrimaryGreen = Color(0xFF1BAE76);
const Color kGreyColor = Color(0xFF808080);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kScaffoldBackground = Color(0xFFEFEFEF);

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // --- STATE KERANJANG ---
  // Untuk saat ini, kita buat list-nya kosong
  final List<dynamic> _cartItems = []; // Nanti ini akan diisi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar (Header Hijau)
      // Otomatis mengambil tema dari main.dart
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        centerTitle: true,
        automaticallyImplyLeading: false, // Hapus tombol back
      ),

      // 2. Body
      // Kita cek apakah keranjang kosong atau tidak
      body: _cartItems.isEmpty
          ? _buildEmptyCart() // Tampilkan ini jika keranjang kosong
          : _buildCartList(), // Tampilkan ini jika ada isinya
    );
  }

  // --- WIDGET UNTUK TAMPILAN KERANJANG KOSONG ---
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: kGreyColor.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            "Keranjang Anda masih kosong",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Yuk, tambahkan kopi favoritmu!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kGreyColor,
                ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Arahkan kembali ke Halaman Home
              // Ini butuh state management, kita siapkan saja dulu
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Bentuk stadium/pil
              ),
            ),
            child: Text(
              "Lihat Menu",
              style: GoogleFonts.poppins(
                color: kWhiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- WIDGET UNTUK TAMPILAN JIKA ADA ISI ---
  Widget _buildCartList() {
    // (NANTI KITA ISI)
    // Ini akan berisi ListView dari item,
    // ringkasan total harga, dan tombol "Checkout"
    return const Center(
      child: Text("Ada item di keranjang!"), // Placeholder
    );
  }
}