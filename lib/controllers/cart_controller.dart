import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  // List reaktif untuk menyimpan item yang tampil di layar
  var cartItems = <CartItem>[].obs;
  // List reaktif untuk menyimpan kunci (key) unik dari Hive agar mudah dihapus
  var itemKeys = <dynamic>[].obs; 

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  void loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';

    var box = Hive.box<CartItem>('cartBox');
    
    // Bersihkan list sebelum memuat ulang
    cartItems.clear();
    itemKeys.clear();

    // Loop semua isi box Hive
    for (var key in box.keys) {
      var item = box.get(key);
      // Filter: Hanya ambil item yang username-nya sama dengan user yang sedang login
      if (item != null && item.username == username) {
        cartItems.add(item);
        itemKeys.add(key); // Simpan key-nya untuk proses hapus nanti
      }
    }
  }

  void deleteItem(int index) async {
    var box = Hive.box<CartItem>('cartBox');
    
    // Ambil key Hive berdasarkan index list yang diklik
    var keyToDelete = itemKeys[index];
    
    // Hapus dari database Hive
    await box.delete(keyToDelete);
    
    // Hapus dari tampilan UI secara real-time
    cartItems.removeAt(index);
    itemKeys.removeAt(index);
    
    Get.snackbar("Berhasil", "Item dihapus dari keranjang", snackPosition: SnackPosition.BOTTOM);
  }
}