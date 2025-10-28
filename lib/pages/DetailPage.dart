// lib/pages/detail_page.dart
import 'package:flutter/material.dart';
import '../models/CoffeModel.dart'; // Import model Anda

// Ambil warna dari main.dart
const Color kPrimaryGreen = Color(0xFF1BAE76);
const Color kWhiteColor = Color(0xFFFFFFFF);

class DetailPage extends StatelessWidget {
  // 1. Variabel untuk "menangkap" data kopi yang dikirim dari HomePage
  final Coffee coffee;

  // 2. Constructor yang mewajibkan pengiriman data 'coffee'
  const DetailPage({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. AppBar otomatis mengambil tema dari main.dart (hijau)
      // dan otomatis menambahkan tombol "kembali" (back button)
      appBar: AppBar(
        title: Text(coffee.name),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 4. Gambar Hero (Gambar Besar)
            Image.network(
              coffee.imageUrl,
              width: double.infinity,
              height: 300, // Tentukan tinggi gambar
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 80),
                );
              },
            ),

            // 5. Konten Teks (Nama, Harga, Deskripsi)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    coffee.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    "Rp ${coffee.price.toStringAsFixed(0)}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kPrimaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Judul Deskripsi
                  Text(
                    "Deskripsi",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),

                  // Isi Deskripsi
                  Text(
                    coffee.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      height: 1.5, // Jarak antar baris
                    ),
                  ),

                  const SizedBox(height: 32),
                  
                  // 6. Tombol Add to Cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Tambahkan logika 'add to cart'
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        "Tambah ke Keranjang",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: kWhiteColor,
                          fontSize: 16
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}