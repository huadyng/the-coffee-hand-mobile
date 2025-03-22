// File: lib/services/order_detail_service.dart

import 'package:the_coffee_hand_mobile/network/api_client.dart';
import 'package:the_coffee_hand_mobile/models/order_detail_request.dart';
import 'package:the_coffee_hand_mobile/models/order_detail_response.dart';

class OrderDetailService {
  final ApiClient apiClient;

  OrderDetailService({required this.apiClient});

  /// Tạo mới 1 order detail
  Future<OrderDetailResponse> createOrderDetail(OrderDetailRequest request) async {
    // Gửi request POST lên endpoint /order-details
    final responseJson = await apiClient.post('/order-details', request.toJson());
    return OrderDetailResponse.fromJson(responseJson);
  }

  /// Lấy thông tin 1 order detail theo ID
  Future<OrderDetailResponse> getOrderDetailById(String id) async {
    // Gửi request GET đến /order-details/:id
    final responseJson = await apiClient.get('/order-details/$id');
    return OrderDetailResponse.fromJson(responseJson);
  }

// Tuỳ nhu cầu, bạn có thể bổ sung thêm các hàm khác như update, delete,...
}
