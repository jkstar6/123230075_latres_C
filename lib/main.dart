import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import halaman dan model
import 'controllers/auth_controller.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';
import 'models/cart_model.dart'; // Ini wajib ditambahkan agar Hive mengenali CartItem

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');

  // --- TAMBAHKAN BARIS INI ---
  // Inisialisasi AuthController secara global
  Get.put(AuthController());

  // Cek session
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MyApp(isLoggedIn: username != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsi App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,

      // Logika penentuan halaman awal
      home: isLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
