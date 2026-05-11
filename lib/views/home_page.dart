import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Awikwok"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Nanti kita arahkan ke halaman Cart
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Daftar Produk API akan muncul di sini"),
      ),
    );
  }
}