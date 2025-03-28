import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../config/app_config.dart';

mixin CategoryViewMixin<T extends StatefulWidget> on State<T> {
  int selectedCategoryIndex = 0; // Chỉ mục của danh mục được chọn

  List<String> categories = []; // 🔹 Lấy từ API thay vì danh sách cứng
  List<Map<String, dynamic>> products = [];

  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCategories(); // 🔹 Gọi API lấy danh mục trước
  }

// 🔹 API lấy danh sách danh mục từ Swagger
  Future<void> fetchCategories() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = Uri.parse("${AppConfig.apiBaseUrl}/categories/paginated?pageNumber=1&pageSize=10"); // 🔹 Sử dụng apiBaseUrl

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        List<String> fetchedCategories =
        List<String>.from(jsonData["items"].map((item) => item["name"]));

        setState(() {
          categories = fetchedCategories; // 🔹 Cập nhật danh mục từ API
        });

        // 🔹 Gọi API lấy sản phẩm nếu danh mục không rỗng
        if (categories.isNotEmpty) {
          selectedCategoryIndex = 0; // Chọn danh mục đầu tiên
          fetchDrinksByCategory(categories[selectedCategoryIndex]);
        }
      } else {
        setState(() {
          errorMessage = "Lỗi: Không thể lấy danh mục (Mã lỗi ${response.statusCode})";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Lỗi khi lấy danh mục: $error";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

// 🔹 API lấy danh sách sản phẩm theo danh mục
  Future<void> fetchDrinksByCategory(String category) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final url = Uri.parse("${AppConfig.apiBaseUrl}/drink/paginated?pageNumber=1&pageSize=10");
    print("🟢 Gọi API đến URL: $url");  // In ra URL đang gọi

    try {
      final response = await http.get(url);
      print("📥 Nhận được phản hồi từ API (Status Code: ${response.statusCode})"); // In ra mã trạng thái

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body); // API trả về một Map
        print("✅ Dữ liệu nhận được từ API: $jsonData");

        // Kiểm tra xem sản phẩm có thuộc category mong muốn không
        if (jsonData == null || jsonData["items"] == null) {
          throw "Dữ liệu API không hợp lệ hoặc rỗng!";
        }

        List<Map<String, dynamic>> loadedProducts = [];

        for (var item in jsonData["items"]) {
          // 🔹 CHỈNH SỬA Ở ĐÂY: Kiểm tra `category` trước khi truy cập `name`
          var categoryData = item["category"];
          if (categoryData != null && categoryData["name"] == category) {

            loadedProducts.add({
              "name": item["name"] ?? "No name",
              "category": categoryData["name"],// 🔹 CHỈNH SỬA Ở ĐÂY: Xử lý null
              "description": item["description"] ?? "No description", // 🔹 CHỈNH SỬA Ở ĐÂY: Xử lý null
              "price": item["price"]?.toString() ?? "0", // 🔹 CHỈNH SỬA Ở ĐÂY: Xử lý null
              "image": item["imageUrl"] ?? "assets/images/default-profile-photo.png" // 🔹 CHỈNH SỬA Ở ĐÂY: Xử lý null
            });
          }
        }

        setState(() {
          products = loadedProducts;
        });

        print("📌 Dữ liệu sau khi lọc và xử lý: $products");
      } else {
        setState(() {
          errorMessage = "Lỗi: Không thể lấy dữ liệu (Mã lỗi ${response.statusCode})";
        });
        print("❌ Lỗi khi gọi API: Mã lỗi ${response.statusCode}");
      }
    } catch (error) {
      setState(() {
        errorMessage = "Lỗi khi gọi API: $error";
      });
      print("⚠️ Lỗi xảy ra khi gọi API: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
      print("🔄 Hoàn thành việc gọi API, isLoading = false");
    }
  }

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
            fetchDrinksByCategory(categories[index]);
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
      return item["category"] == selectedCategory;
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
                  child: Image.network(
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
