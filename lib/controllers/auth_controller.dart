import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/login_page.dart';
import '../views/main_page.dart';

class AuthController extends GetxController {
  // Controller untuk menangkap input teks
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Gantilah '123210001' dengan NIM asli kamu atau sesuaikan logikanya
  final String correctPassword = "123230075"; 

  void login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Username dan Password tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validasi Password wajib NIM 
    if (password == correctPassword) {
      // Simpan username ke SharedPreferences [cite: 9]
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      Get.snackbar("Success", "Selamat Datang, $username!");
      
      // Pindah ke halaman utama (kita akan buat nanti)
      Get.offAll(() => const MainPage()); 
    } else {
      Get.snackbar("Error", "Password harus menggunakan NIM kamu",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    // Kembali ke login dan hapus semua history navigasi
    Get.offAll(() => const LoginPage()); 
  }
}