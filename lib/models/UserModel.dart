// lib/models/user_model.dart

class User {
  final String id;
  final String email;
  final String password;
  final String name; // atau 'nama_lengkap', sesuaikan dengan MockAPI Anda

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
  });

  // "Penerjemah" dari JSON ke Objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'], // sesuaikan key ini jika beda
    );
  }
}