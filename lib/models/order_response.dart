class OrderResponse {
  final String id;
  final String userId;
  final int status;
  final DateTime date;
  final double? totalPrice; // Nếu backend trả về thông tin tổng tiền
  // Nếu có danh sách OrderDetails, có thể bổ sung thêm trường: List<OrderDetailResponse> orderDetails;

  OrderResponse({
    required this.id,
    required this.userId,
    required this.status,
    required this.date,
    this.totalPrice,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'],
      userId: json['userId'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      totalPrice: json['totalPrice'] != null ? (json['totalPrice'] as num).toDouble() : null,
    );
  }
}
