// File: lib/services/order_service.dart

import 'package:the_coffee_hand_mobile/network/api_client.dart';
import 'package:the_coffee_hand_mobile/models/order_request.dart';
import 'package:the_coffee_hand_mobile/models/order_response.dart';

class OrderService {
  final ApiClient apiClient;

  OrderService({required this.apiClient});

  /// Hàm tạo mới 1 order
  Future<OrderResponse> createOrder(OrderRequest orderRequest) async {
    // Gửi request POST lên endpoint /orders (tuỳ theo backend)
    final responseJson = await apiClient.post('/orders/test-message', orderRequest.toJson());
    return OrderResponse.fromJson(responseJson);
  }

  /// Hàm lấy thông tin 1 order theo ID
  Future<OrderResponse> getOrderById(String orderId) async {
    final responseJson = await apiClient.get('/orders/$orderId');
    return OrderResponse.fromJson(responseJson);
  }

// Bạn có thể bổ sung thêm các hàm khác như updateOrder, deleteOrder, confirmOrder, v.v.
}
