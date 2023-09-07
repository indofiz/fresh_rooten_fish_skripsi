import 'package:cloud_firestore/cloud_firestore.dart';

class Prediksi {
  String id;
  final String email;
  final String tanggal;
  final String waktu;
  final List<dynamic> prediksi;
  final String urlgambar;
  final DateTime createdAt;

  Prediksi({
    this.id = '',
    required this.email,
    required this.tanggal,
    required this.waktu,
    required this.prediksi,
    required this.urlgambar,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'tanggal': tanggal,
        'waktu': waktu,
        'prediksi': prediksi,
        'urlgambar': urlgambar,
        'createdAt': createdAt,
      };

  static Prediksi fromJson(Map<String, dynamic> json) => Prediksi(
        id: json['id'],
        email: json['email'],
        tanggal: json['tanggal'],
        waktu: json['waktu'],
        prediksi: List.from(json['prediksi'] ?? []),
        urlgambar: json['urlgambar'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
