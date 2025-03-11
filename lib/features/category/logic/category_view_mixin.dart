import 'package:flutter/material.dart';

mixin CategoryViewMixin<T extends StatefulWidget> on State<T> {
  int selectedCategoryIndex = 0; // Chỉ mục của danh mục được chọn

  final List<String> categories = ["Cappuccino", "Macchiato", "Latte"];

  final List<Map<String, String>> products = [
    {
      "name": "Cappuccino",
      "description": "with Chocolate",
      "price": "4.53",
      "image": "assets/images/default-profile-photo.png"
    },
    {
      "name": "Cappuccino",
      "description": "with Oat Milk",
      "price": "3.90",
      "image": "assets/images/default-profile-photo.png"
    },
    {
      "name": "Macchiato",
      "description": "Caramel Flavor",
      "price": "5.20",
      "image": "assets/images/default-profile-photo.png"
    },
    {
      "name": "Latte",
      "description": "Creamy & Smooth",
      "price": "4.80",
      "image": "assets/images/default-profile-photo.png"
    },
  ];

  // Tạo danh sách button category
  List<Widget> buildCategoryButtons() {
    return List.generate(categories.length, (index) {
      bool isSelected = index == selectedCategoryIndex;
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedCategoryIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  // Hiển thị danh sách sản phẩm theo dạng grid
  List<Widget> buildCategoryItems() {
    // Lọc sản phẩm dựa trên danh mục đang chọn
    final selectedCategory = categories[selectedCategoryIndex];
    final filteredProducts = products.where((item) {
      return item["name"] == selectedCategory;
    }).toList();

    // Tạo danh sách widget từ các sản phẩm đã lọc
    return filteredProducts.map((item) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item["image"]!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item["name"]!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item["description"]!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${item["price"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 30,
                      minHeight: 30,
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      // Thêm vào giỏ hàng
                    },
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
