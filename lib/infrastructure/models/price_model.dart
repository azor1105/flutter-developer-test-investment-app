import '../../domain/entities/price_entity.dart';

class PriceModel extends PriceEntity {
  const PriceModel({
    required super.price,
    required super.changePercent,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      price: (json['price'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'changePercent': changePercent,
    };
  }

  PriceEntity toEntity() {
    return PriceEntity(
      price: price,
      changePercent: changePercent,
    );
  }

  factory PriceModel.fromEntity(PriceEntity entity) {
    return PriceModel(
      price: entity.price,
      changePercent: entity.changePercent,
    );
  }
}
