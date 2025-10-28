// lib/pages/profile_page.dart
import 'package:flutter/material.dart';

// Ambil warna dari main.dart (atau definisikan ulang di sini)
const Color kPrimaryGreen = Color(0xFF1BAE76);
const Color kGreyColor = Color(0xFF808080);
const Color kWhiteColor = Color(0xFFFFFFFF);

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar (Header Hijau)
      appBar: AppBar(
        title: const Text("Profile Saya"),
        centerTitle: true,
        automaticallyImplyLeading: false, // Hapus tombol back
      ),

      // 2. Body Halaman
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Posisikan di tengah
            children: [
              // 3. Avatar untuk foto profil
              const CircleAvatar(
                radius: 60, // Ukuran avatar
                backgroundColor: kPrimaryGreen,
                child: Icon(Icons.person, size: 60, color: kWhiteColor),
                // Jika punya foto di assets:
                // backgroundImage: AssetImage('assets/images/foto_profil.jpg'),
              ),
              const SizedBox(height: 24),

              // 4. Teks Info Mahasiswa (Silakan ganti)
              _buildProfileInfo(
                context,
                icon: Icons.person_outline,
                text: "Nama Anda Di Sini", // <-- Ganti Nama Anda
              ),
              const SizedBox(height: 16),
              _buildProfileInfo(
                context,
                icon: Icons.badge_outlined,
                text: "NIM Anda Di Sini", // <-- Ganti NIM Anda
              ),
              const SizedBox(height: 16),
              _buildProfileInfo(
                context,
                icon: Icons.class_outlined,
                text: "Kelas Anda Di Sini", // <-- Ganti Kelas Anda
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Helper ---
  // Widget internal untuk membuat baris info (Icon + Teks)
  Widget _buildProfileInfo(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: kWhiteColor, // Latar belakang putih
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
          Icon(icon, color: kPrimaryGreen, size: 24),
          const SizedBox(width: 20),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
