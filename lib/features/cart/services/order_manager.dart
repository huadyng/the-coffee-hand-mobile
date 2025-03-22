// File: lib/features/cart/services/order_manager.dart

import 'package:the_coffee_hand_mobile/network/api_client.dart';
import 'package:the_coffee_hand_mobile/models/order_request.dart';
import 'package:the_coffee_hand_mobile/models/order_response.dart';
import 'package:the_coffee_hand_mobile/models/order_detail_request.dart';
import 'package:the_coffee_hand_mobile/models/order_detail_response.dart';
import 'package:the_coffee_hand_mobile/services/order_service.dart';
import 'package:the_coffee_hand_mobile/services/order_detail_service.dart';

class OrderManager {
  final ApiClient apiClient;
  late final OrderService orderService;
  late final OrderDetailService orderDetailService;

  OrderManager({required this.apiClient}) {
    orderService = OrderService(apiClient: apiClient);
    orderDetailService = OrderDetailService(apiClient: apiClient);
  }

  /// Hàm tạo mới đơn hàng với Milk Coffee (ví dụ: số lượng 1)
  Future<void> createNewOrderWithMilkCoffee(String userId) async {
    try {
      // 1. Tạo mới order với trạng thái cart (status = 0)
      final orderRequest = OrderRequest(userId: userId, status: 0);
      OrderResponse orderResponse = await orderService.createOrder(orderRequest);
      print("Order created with id: ${orderResponse.id}");

      // 2. Tạo order detail cho Milk Coffee (với id đã cho và số lượng 1)
      // final orderDetailRequest = OrderDetailRequest(
      //   orderId: orderResponse.id,
      //   drinkId: "13A27675-CC46-4DDC-ABA5-E1A5151475C7",
      //   total: 1,
      // );
      // OrderDetailResponse orderDetailResponse =
      // await orderDetailService.createOrderDetail(orderDetailRequest);
      // print("Order detail created with id: ${orderDetailResponse.id}");

      // Sau khi tạo thành công, bạn có thể thực hiện chuyển hướng hay thông báo thành công cho UI.
    } catch (error) {
      print("Checkout error: $error");
      rethrow;
    }
  }

  /// Hàm xử lý checkout tổng quát được gọi từ UI sau khi nhấn nút Checkout
  Future<void> handleCheckout(String userId) async {
    // Ở ví dụ này, chúng ta chỉ checkout với Milk Coffee.
    await createNewOrderWithMilkCoffee(userId);
  }
}
