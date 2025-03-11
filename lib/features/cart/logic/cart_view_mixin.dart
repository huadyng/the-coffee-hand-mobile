import 'package:flutter/material.dart';

mixin CartViewMixin<T extends StatefulWidget> on State<T> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Pitch Black Coffee",
      "description": "With Sprinkels",
      "price": 13000,
      "image": "assets/images/default-profile-photo.png",
      "size": "Small",
      "quantity": 1,
    },
    {
      "name": "Executive Expresso",
      "description": "With Milk",
      "price": 20000,
      "image": "assets/images/default-profile-photo.png",
      "size": "Large",
      "quantity": 1,
    },
  ];

  // Hàm tính tổng giá trị giỏ hàng
  int getTotalPrice() {
    return cartItems.fold<int>(0, (sum, item) {
      int price = (item["price"] as num).toInt(); // Chuyển giá về int
      int quantity = (item["quantity"] as num).toInt(); // Chuyển số lượng về int
      return sum + (price * quantity);
    });
  }


  // Hàm tăng số lượng
  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  // Hàm giảm số lượng
  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  // Hàm xoá sản phẩm khỏi giỏ hàng
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Widget hiển thị từng sản phẩm trong giỏ hàng
  Widget buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item["image"], width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // Thông tin sản phẩm
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["name"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(item["description"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Text("Rp ${item["price"]}", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Chọn size, tăng/giảm số lượng, nút xoá
          Column(
            children: [
              // Nút chọn size
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(item["size"], style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),

              // Nút tăng/giảm số lượng
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                    onPressed: () => decreaseQuantity(index),
                  ),
                  Text("${item["quantity"]}", style: const TextStyle(color: Colors.white, fontSize: 14)),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 16),
                    onPressed: () => increaseQuantity(index),
                  ),
                ],
              ),
            ],
          ),

          // Nút xoá
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white, size: 18),
            onPressed: () => removeItem(index),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị tổng tiền và nút checkout
  Widget buildCartSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16), // Tránh che bởi Bottom Navigation
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal (${cartItems.length} items)", style: const TextStyle(color: Colors.white, fontSize: 14)),
              Text("Rp ${getTotalPrice()}", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),

          // Nút Checkout
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // Xử lý thanh toán
              },
              child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
