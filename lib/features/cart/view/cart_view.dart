import 'package:flutter/material.dart';
import '../logic/cart_view_mixin.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with CartViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Shopping Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea( // Giúp tránh che bởi navigation bar
        child: Column(
          children: [
            // Danh sách sản phẩm
            Expanded( // Đảm bảo ListView chiếm phần trên, không đẩy xuống dưới
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80), // Tránh bị che bởi nút checkout
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return buildCartItem(item, index);
                },
              ),
            ),

            // Subtotal + Checkout Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16), // Tránh bị che
              child: buildCartSummary(),
            ),
          ],
        ),
      ),
    );
  }
}
