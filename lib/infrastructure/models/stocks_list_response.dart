import 'stock_model.dart';

class StocksListResponse {
  final List<StockModel> data;

  const StocksListResponse({
    required this.data,
  });

  factory StocksListResponse.fromJson(Map<String, dynamic> json) {
    return StocksListResponse(
      data: (json['data'] as List<dynamic>)
          .map((stockJson) =>
              StockModel.fromJson(stockJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((stock) => stock.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StocksListResponse && other.data.length == data.length;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'StocksListResponse(data: ${data.length} items)';
}
