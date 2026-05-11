class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final int stock; // Ini akan jadi totalQty nantinya
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.thumbnail,
  });

  // Fungsi untuk memetakan JSON ke Model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      // Kadang API mengembalikan int atau double untuk harga, kita pastikan jadi double
      price: json['price'].toDouble(), 
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }
}