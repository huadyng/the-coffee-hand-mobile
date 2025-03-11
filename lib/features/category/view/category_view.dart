import 'package:flutter/material.dart';
import '../logic/category_view_mixin.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> with CategoryViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea( // Tránh bị che bởi các phần khác của màn hình
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thanh tìm kiếm
              TextField(
                decoration: InputDecoration(
                  hintText: "Search coffee",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),

              // Danh sách danh mục
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: buildCategoryButtons(),
                ),
              ),

              const SizedBox(height: 20),

              // Bọc GridView trong Expanded để tránh lỗi tràn
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.682,
                    // Loại bỏ shrinkWrap để GridView mở rộng đầy đủ
                    physics: const BouncingScrollPhysics(),
                    children: buildCategoryItems(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
