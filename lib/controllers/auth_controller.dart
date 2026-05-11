import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/login_page.dart';
import '../views/main_page.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final String correctPassword = "123230075"; 

  void login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Username dan Password tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password == correctPassword) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      Get.snackbar("Success", "Selamat Datang, $username!");
      
      Get.offAll(() => const MainPage()); 
    } else {
      Get.snackbar("Error", "Password harus menggunakan NIM kamu",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Get.offAll(() => const LoginPage()); 
  }
}