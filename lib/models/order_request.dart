class OrderRequest {
  final String userId;
  final int status; // 0: Cart, 1: Confirmed, v.v.
  // Có thể bổ sung thêm các trường khác nếu cần (ví dụ: totalPrice, list orderDetails, ...)

  OrderRequest({
    required this.userId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'status': status,
      // Thêm các trường khác nếu có
    };
  }
}
