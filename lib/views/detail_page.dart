import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  // Kita inisialisasi variabel rx (reaktif) untuk kuantitas
  // Nilai awal adalah 1, karena soal mensyaratkan 0 < qty <= totalQty
  DetailPage({super.key, required this.product});

  final RxInt qty = 1.obs;

  void _addToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? 'User';

    // Ambil box yang sudah kita buka di main.dart
    var box = Hive.box<CartItem>('cartBox');

    // Buat objek item baru
    var newItem = CartItem(
      username: username,
      productId: product.id,
      title: product.title,
      price: product.price,
      thumbnail: product.thumbnail,
      qty: qty.value,
    );

    // Simpan ke Hive
    await box.add(newItem);

    Get.snackbar(
      "Berhasil", 
      "${product.title} ditambahkan ke keranjang",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.thumbnail, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text(product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product.price} | Stok: ${product.stock}", style: const TextStyle(fontSize: 18, color: Colors.blue)),
            const SizedBox(height: 20),
            Text(product.description),
            const Spacer(),
            
            // Bagian Pengaturan Kuantitas & Tombol Add to Cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Kontrol Kuantitas
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (qty.value > 1) qty.value--;
                      },
                    ),
                    Obx(() => Text("${qty.value}", style: const TextStyle(fontSize: 20))),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        if (qty.value < product.stock) qty.value++;
                      },
                    ),
                  ],
                ),
                // Tombol Add to Cart
                ElevatedButton.icon(
                  onPressed: _addToCart,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}