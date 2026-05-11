import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/product_controller.dart';
import 'detail_page.dart';
// import 'cart_page.dart'; // Nanti kita buat
// import 'detail_page.dart'; // Nanti kita buat

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller di sini agar API langsung di-fetch
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _getUsername(),
          builder: (context, snapshot) {
            return Text("Hai, ${snapshot.data ?? ''}");
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Get.to(() => const CartPage());
            },
          ),
        ],
      ),
      // Obx akan memantau isLoading dan productList
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.productList.isEmpty) {
          return const Center(child: Text("Tidak ada produk tersedia"));
        }

        return ListView.builder(
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            var product = productController.productList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(
                  product.thumbnail,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  // Menangani jika gambar gagal dimuat
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
                title: Text(
                  product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("\$${product.price} | Stock: ${product.stock}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Sekarang sudah bisa diarahkan ke halaman detail
                  Get.to(() => DetailPage(product: product));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
