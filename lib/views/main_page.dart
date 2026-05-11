import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());

    // List halaman yang akan ditampilkan di dalam body
    final List<Widget> pages = [
      const HomePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      // Obx akan membungkus widget yang state-nya berubah-ubah
      body: Obx(() => pages[mainController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: mainController.selectedIndex.value,
          onTap: mainController.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}