import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true); // Ubah state jadi loading
      
      var response = await http.get(Uri.parse('https://dummyjson.com/products'));
      
      if (response.statusCode == 200) {
        // Decode JSON dari API
        var jsonString = json.decode(response.body);
        
        // array ubah ke list of Product Model
        var products = jsonString['products'] as List;
        productList.value = products.map((e) => Product.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Gagal mengambil data dari server");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }
}