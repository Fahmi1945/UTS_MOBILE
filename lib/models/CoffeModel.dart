class Coffee {
  final int id;
  final String nama;
  final String gambarUrl;
  final String deskripsi;
  final List<String> bahan;

  Coffee({
    required this.id,
    required this.nama,
    required this.gambarUrl,
    required this.deskripsi,
    required this.bahan,
  });

  // Factory constructor untuk parsing JSON
  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json['id'],
      nama: json['nama'],
      gambarUrl: json['gambar_url'],
      deskripsi: json['deskripsi'],
      bahan: List<String>.from(json['bahan']),
    );
  }
}