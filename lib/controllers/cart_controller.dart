import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
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
    
    cartItems.clear();
    itemKeys.clear();

    for (var key in box.keys) {
      var item = box.get(key);
      // Hanya ambil item yang user yang sedang login
      if (item != null && item.username == username) {
        cartItems.add(item);
        itemKeys.add(key);
      }
    }
  }

  void deleteItem(int index) async {
    var box = Hive.box<CartItem>('cartBox');
    
    var keyToDelete = itemKeys[index];
    
    await box.delete(keyToDelete);
    
    cartItems.removeAt(index);
    itemKeys.removeAt(index);
    
    Get.snackbar("Berhasil", "Item dihapus dari keranjang", snackPosition: SnackPosition.BOTTOM);
  }
}