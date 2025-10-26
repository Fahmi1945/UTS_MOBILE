import 'package:flutter/material.dart';
// 1. Import model Coffee agar file ini tahu apa itu objek 'Coffee'
import '../models/CoffeModel.dart';

class DetailPage extends StatelessWidget {
  // 2. Variabel untuk "menangkap" data kopi yang dikirim
  final Coffee coffee;

  // 3. Constructor yang mewajibkan pengiriman data 'coffee'
  const DetailPage({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 4. AppBar otomatis menampilkan tombol kembali (back)
      appBar: AppBar(
        title: Text(coffee.nama), // Judul AppBar diambil dari nama kopi
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 5. Menampilkan gambar dari aset lokal
            // 5. Menampilkan gambar dari URL Internet
            Image.network(
              coffee.gambarUrl, // Mengambil URL gambar dari objek coffee
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,

              // (Pro Tip) Tambahkan loading indicator di sini juga
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 300, // Samakan tinggi dengan gambar
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
              // (Pro Tip) Tampilkan error di sini juga
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300,
                  child: const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
                );
              },
            ),

            // 6. Padding untuk memberi jarak konten di bawah gambar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menampilkan Nama Kopi
                  Text(
                    coffee.nama,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 8),

                  // Menampilkan Harga Kopi
                  Text(
                    coffee.harga,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Menampilkan Deskripsi Kopi
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    coffee.deskripsi,
                    style: const TextStyle(fontSize: 16, height: 1.5),
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
