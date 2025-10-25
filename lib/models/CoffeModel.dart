class Coffee {
  final int id;
  final String nama;
  final String harga;
  final String gambarUrl;
  final String deskripsi;

  Coffee({
    required this.id,
    required this.nama,
    required this.harga,
    required this.gambarUrl,
    required this.deskripsi,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      gambarUrl: json['gambar_url'],
      deskripsi: json['deskripsi'],
    );
  }
}