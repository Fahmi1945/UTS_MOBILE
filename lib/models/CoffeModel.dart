// lib/models/coffee_model.dart

class Coffee {
  final String id;
  final String name;
  final double price; // Kita simpan sebagai angka (double)
  final String imageUrl;
  final String description;
  // field 'rating' sudah dihapus

  Coffee({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    // 'rating' sudah dihapus dari constructor
  });

  // Ini adalah "penerjemah" utama dari JSON ke Objek Coffee
  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json['id'],
      name: json['name'],
      // API mengirim 'price' sebagai String (misal "22000.00")
      // Kita ubah (parse) menjadi angka (double) agar bisa dihitung
      price: double.parse(json['price']),
      
      imageUrl: json['imageUrl'],
      description: json['description'],

      // 'rating' sudah dihapus dari factory
    );
  }
}