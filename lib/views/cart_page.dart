import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi CartController
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Saya")),
      body: Obx(() {
        // Cek jika keranjang kosong
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text("Keranjangmu masih kosong", style: TextStyle(fontSize: 18)),
          );
        }

        // Tampilkan list barang
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            var item = cartController.cartItems[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(
                  item.thumbnail, 
                  width: 50, 
                  height: 50, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("\$${item.price} | Qty: ${item.qty}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Panggil fungsi hapus dari controller
                    cartController.deleteItem(index);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}