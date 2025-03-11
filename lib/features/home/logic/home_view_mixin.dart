import 'package:flutter/material.dart';

mixin HomeViewMixin<T extends StatefulWidget> on State<T> {
  // Danh mục (4 cột)
  List<Widget> buildCategoryList() {
    final categories = [
      {"name": "Hot Coffee", "image": "assets/images/default-profile-photo.png"},
      {"name": "Cold Coffee", "image": "assets/images/default-profile-photo.png"},
      {"name": "Juice", "image": "assets/images/default-profile-photo.png"},
      {"name": "Tea", "image": "assets/images/default-profile-photo.png"},
    ];

    return categories.map((category) {
      return Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.brown.shade100,
            ),
            child: Center(
              child: Image.asset(category["image"]!, width: 40),
            ),
          ),
          const SizedBox(height: 4),
          Text(category["name"]!, style: const TextStyle(fontSize: 12)),
        ],
      );
    }).toList();
  }

  List<Widget> buildPopularItems() {
    final items = [
      {
        "name": "Caffe Mocha",
        "description": "Deep Foam",
        "price": "4.53",
        "image": "assets/images/default-profile-photo.png"
      },
      {
        "name": "Cold Coffee",
        "description": "Ice Brewed",
        "price": "5.22",
        "image": "assets/images/default-profile-photo.png"
      },
      {
        "name": "Ice Tea",
        "description": "Lemon Fresh",
        "price": "5.22",
        "image": "assets/images/default-profile-photo.png"
      },
    ];

    return items.map((item) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Đổ bóng nhẹ
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm + Rating ⭐
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(item["image"]!, height: 80, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),

            const SizedBox(height: 8),
            // Tên đồ uống
            Text(
              item["name"]!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            // Mô tả
            Text(
              item["description"]!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const SizedBox(height: 8),
            // Giá + Nút thêm vào giỏ hàng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${item["price"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    onPressed: () {}, // Thêm vào giỏ hàng
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}
