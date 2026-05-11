# Latihan Responsi IF-C: Toko Awikshop 🛒

**Oleh:** Bintang Jati Kesuma Subagyo
**NIM:** 123230075
**Kelas:** IF-C

---

## 📁 Struktur Folder (Arsitektur GetX)

```text
lib/
│
├── controllers/       # Tempat menyimpan logika bisnis dan state management (GetX)
│   ├── auth_controller.dart    # Menangani logika validasi login, session, dan logout
│   ├── cart_controller.dart    # Menangani logika CRUD keranjang belanja (Hive)
│   ├── main_controller.dart    # Menangani state navigasi BottomNavigationBar
│   └── product_controller.dart # Menangani proses HTTP GET request ke dummyjson API
│
├── models/            # Tempat menyimpan blueprint/cetakan objek data
│   ├── cart_model.dart         # Model untuk item keranjang (beserta TypeAdapter Hive)
│   └── product_model.dart      # Model untuk parsing data JSON dari API ke objek Dart
│
├── views/             # Tempat menyimpan seluruh halaman UI (User Interface)
│   ├── cart_page.dart          # Halaman daftar keranjang belanja pengguna
│   ├── detail_page.dart        # Halaman detail produk dan fitur penambahan kuantitas
│   ├── home_page.dart          # Halaman utama berisi daftar produk dari API
│   ├── login_page.dart         # Halaman autentikasi awal (Username & NIM)
│   ├── main_page.dart          # Kerangka utama penyedia BottomNavigationBar
│   └── profile_page.dart       # Halaman informasi akun dan tombol logout
│
└── main.dart          # Entry point aplikasi, inisialisasi Hive, dan router utama
