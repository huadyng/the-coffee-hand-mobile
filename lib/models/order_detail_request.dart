class OrderDetailRequest {
  final String orderId;
  final String drinkId;
  final int total; // Số lượng món, hoặc tổng tiền chi tiết
  // Có thể bổ sung thêm các trường khác nếu cần (ví dụ: price, note,...)

  OrderDetailRequest({
    required this.orderId,
    required this.drinkId,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'drinkId': drinkId,
      'total': total,
      // Thêm các trường khác nếu có
    };
  }
}
