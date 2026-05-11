import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import halaman-halaman kamu di sini nanti
// import 'view/login_page.dart';
// import 'view/home_page.dart';

void main() async {
  // 1. Memastikan binding framework Flutter sudah siap
  // Ini wajib dipanggil jika ada kode async sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi Hive untuk database lokal
  await Hive.initFlutter();

  // 3. Cek session di SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  // Jalankan aplikasi dengan membawa status login
  runApp(MyApp(isLoggedIn: username != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      
      // 4. Logika penentuan halaman awal
      // Jika isLoggedIn true, ke HomePage, jika false ke LoginPage
      home: isLoggedIn 
          ? const PlaceholderPage(title: "Halaman Utama (Sudah Login)") 
          : const PlaceholderPage(title: "Halaman Login"),
    );
  }
}

// Widget sementara untuk testing sebelum kamu membuat file UI
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Latihan Responsi")),
      body: Center(child: Text(title)),
    );
  }
}