class OrderDetailResponse {
  final String id;
  final String orderId;
  final String drinkId;
  final int total;
  // Nếu backend trả về thêm thông tin chi tiết của món (như tên, giá, hình ảnh, ...) thì có thể bổ sung thêm các trường khác

  OrderDetailResponse({
    required this.id,
    required this.orderId,
    required this.drinkId,
    required this.total,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      id: json['id'],
      orderId: json['orderId'],
      drinkId: json['drinkId'],
      total: json['total'],
    );
  }
}
