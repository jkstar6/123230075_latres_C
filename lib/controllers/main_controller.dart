import 'package:get/get.dart';

class MainController extends GetxController {
  // Menggunakan .obs agar reaktif ketika nilai berubah
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}