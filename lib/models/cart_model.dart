import 'package:hive/hive.dart';

class CartItem {
  final String username;
  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  int qty;

  CartItem({
    required this.username,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.qty,
  });
}

// Ini adalah Adapter manual agar Hive mengenali class CartItem
class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0; // ID unik untuk model ini

  @override
  CartItem read(BinaryReader reader) {
    return CartItem(
      username: reader.readString(),
      productId: reader.readInt(),
      title: reader.readString(),
      price: reader.readDouble(),
      thumbnail: reader.readString(),
      qty: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer.writeString(obj.username);
    writer.writeInt(obj.productId);
    writer.writeString(obj.title);
    writer.writeDouble(obj.price);
    writer.writeString(obj.thumbnail);
    writer.writeInt(obj.qty);
  }
}