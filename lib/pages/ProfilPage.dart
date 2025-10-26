import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar untuk halaman profil
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: Colors.white, // Sesuaikan dengan tema
        elevation: 1, // Garis tipis di bawah AppBar
      ),
      
      // 2. Body: Konten statis di tengah layar
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Posisikan di tengah
            children: [
              
              // 3. Avatar untuk foto profil
              const CircleAvatar(
                radius: 60, // Ukuran avatar
                // --- GANTI DI SINI ---
                // Jika punya gambar, gunakan AssetImage:
                // backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
                
                // Jika tidak, gunakan placeholder:
                backgroundColor: Colors.brown,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 24),
              
              // 4. Teks Info Mahasiswa (Silakan ganti)
              _buildProfileInfo(
                context,
                icon: Icons.person_outline,
                text: "Budi Setiawan", // <-- Ganti Nama Anda
              ),
              const SizedBox(height: 16),
              _buildProfileInfo(
                context,
                icon: Icons.badge_outlined,
                text: "1234567890", // <-- Ganti NIM Anda
              ),
              const SizedBox(height: 16),
              _buildProfileInfo(
                context,
                icon: Icons.class_outlined,
                text: "TI - 4A", // <-- Ganti Kelas Anda
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Helper ---
  // Widget internal untuk membuat baris info (Icon + Teks)
  // Ini agar kode lebih rapi dan tidak berulang
  Widget _buildProfileInfo(BuildContext context, {required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown, size: 24),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}