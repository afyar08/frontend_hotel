import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final Logger logger = Logger();

Future<void> registerManager(String nama, String email, String password) async {
  final Uri uri = Uri.parse('http://127.0.0.1:8000/api/admin/create_manager');

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Registrasi berhasil
      logger.d('Registrasi berhasil!');
    } else {
      // Gagal melakukan registrasi
      logger.e('Registrasi gagal: ${response.statusCode}');
      logger.e(response.body); // Tampilkan pesan kesalahan dari backend
    }
  } catch (e) {
    // Tangani kesalahan selama proses HTTP request
    logger.e('Kesalahan koneksi: $e');
  }
}

Future<List<dynamic>> getManagers() async {
  final Uri uri = Uri.parse('http://127.0.0.1:8000/api/admin/read_manager');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Berhasil mendapatkan data manager
      return jsonDecode(response.body)['managers'];
    } else {
      // Gagal mendapatkan data manager
      logger.e('Gagal mendapatkan data manager: ${response.statusCode}');
      logger.e(response.body); // Tampilkan pesan kesalahan dari backend
      return [];
    }
  } catch (e) {
    // Tangani kesalahan selama proses HTTP request
    logger.e('Kesalahan koneksi: $e');
    return [];
  }
}

Future<void> updateManager(
    int id, String nama, String email, String password) async {
  final Uri uri =
      Uri.parse('http://127.0.0.1:8000/api/admin/update_manager/$id');

  try {
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Berhasil memperbarui data manager
      logger.d('Data manager berhasil diperbarui!');
    } else {
      // Gagal memperbarui data manager
      logger.e('Gagal memperbarui data manager: ${response.statusCode}');
      logger.e(response.body); // Tampilkan pesan kesalahan dari backend
    }
  } catch (e) {
    // Tangani kesalahan selama proses HTTP request
    logger.e('Kesalahan koneksi: $e');
  }
}

Future<void> deleteManager(int id) async {
  final Uri uri =
      Uri.parse('http://127.0.0.1:8000/api/admin/delete_manager/$id');

  try {
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      // Berhasil menghapus data manager
      logger.d('Data manager berhasil dihapus!');
    } else {
      // Gagal menghapus data manager
      logger.e('Gagal menghapus data manager: ${response.statusCode}');
      logger.e(response.body); // Tampilkan pesan kesalahan dari backend
    }
  } catch (e) {
    // Tangani kesalahan selama proses HTTP request
    logger.e('Kesalahan koneksi: $e');
  }
}
