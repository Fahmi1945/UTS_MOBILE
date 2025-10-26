import 'dart:convert'; // Untuk json.decode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Untuk memanggil API
import 'models/CoffeModel.dart'; // Import model kita

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoffeeAPITester(), // Langsung ke halaman tester
    );
  }
}

class CoffeeAPITester extends StatefulWidget {
  const CoffeeAPITester({Key? key}) : super(key: key);

  @override
  State<CoffeeAPITester> createState() => _CoffeeAPITesterState();
}

class _CoffeeAPITesterState extends State<CoffeeAPITester> {
  // Variabel untuk menampung data dari API
  late Future<List<Coffee>> _coffeeData;

  // --- GANTI URL INI DENGAN URL MOCKAPI ANDA ---
 final String apiUrl = "https://68fe947f7c700772bb1408b8.mockapi.io/coffee";
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data API saat halaman dibuka
    _coffeeData = _fetchCoffeeData();
  }

  // Fungsi untuk mengambil dan mem-parsing data API
  Future<List<Coffee>> _fetchCoffeeData() async {
    // 1. Panggil API
    final response = await http.get(Uri.parse(apiUrl));

    // 2. Cek apakah berhasil (Status Code 200)
    if (response.statusCode == 200) {
      // 3. Ubah JSON (String) menjadi List<dynamic>
      final List<dynamic> jsonList = json.decode(response.body);
      
      // 4. Ubah setiap item di List menjadi objek Coffee
      return jsonList.map((json) => Coffee.fromJson(json)).toList();
    } else {
      // 5. Jika gagal, lemparkan error
      throw Exception('Gagal memuat data dari API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tes API Kopi"),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        // FutureBuilder adalah widget terbaik untuk menangani data API
        child: FutureBuilder<List<Coffee>>(
          future: _coffeeData, // Sumber datanya dari API
          builder: (context, snapshot) {
            
            // --- KASUS 1: API Sedang Loading ---
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // --- KASUS 2: API Gagal (Error) ---
            if (snapshot.hasError) {
              return Text(
                "Terjadi Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              );
            }

            // --- KASUS 3: API Berhasil (hasData) ---
            if (snapshot.hasData) {
              final List<Coffee> coffees = snapshot.data!;
              
              // Tampilkan data dalam ListView sederhana
              return ListView.builder(
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  final coffee = coffees[index];
                  
                  // ListTile adalah cara simpel menampilkan data
                  return ListTile(
                    leading: Image.network(
                      coffee.imageUrl,
                      width: 50,
                      fit: BoxFit.cover,
                      // Error builder jika URL gambar bermasalah
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                    title: Text(coffee.name),
                    subtitle: Text("Rp ${coffee.price.toStringAsFixed(0)}"),
                    trailing: Text("ID: ${coffee.id}"),
                  );
                },
              );
            }

            // --- KASUS 4: Data Kosong (Aneh, tapi mungkin terjadi) ---
            return const Text("Tidak ada data");
          },
        ),
      ),
    );
  }
}