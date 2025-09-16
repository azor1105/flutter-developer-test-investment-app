import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_entity.dart';
import 'price_model.dart';

class StockModel extends StockEntity {
  const StockModel({
    required super.id,
    required super.companyName,
    required super.tradingSymbol,
    required super.logo,
    required super.currency,
    required super.shariahCheck,
    required super.analysisDate,
    required super.isCompliant,
    required super.price,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'] as int,
      companyName: json['companyName'] as String,
      tradingSymbol: json['tradingSymbol'] as String,
      logo: json['logo'] as String,
      currency: json['currency'] as String,
      shariahCheck: json['shariahCheck'] as bool,
      analysisDate: DateTime.parse(json['analysisDate'] as String),
      isCompliant: json['isCompliant'] as bool,
      price: PriceModel.fromJson(json['price'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'tradingSymbol': tradingSymbol,
      'logo': logo,
      'currency': currency,
      'shariahCheck': shariahCheck,
      'analysisDate': analysisDate.toIso8601String(),
      'isCompliant': isCompliant,
      'price': (price as PriceModel).toJson(),
    };
  }

  StockEntity toEntity() {
    return StockEntity(
      id: id,
      companyName: companyName,
      tradingSymbol: tradingSymbol,
      logo: logo,
      currency: currency,
      shariahCheck: shariahCheck,
      analysisDate: analysisDate,
      isCompliant: isCompliant,
      price: PriceEntity(
        price: price.price,
        changePercent: price.changePercent,
      ),
    );
  }

  factory StockModel.fromEntity(StockEntity entity) {
    return StockModel(
      id: entity.id,
      companyName: entity.companyName,
      tradingSymbol: entity.tradingSymbol,
      logo: entity.logo,
      currency: entity.currency,
      shariahCheck: entity.shariahCheck,
      analysisDate: entity.analysisDate,
      isCompliant: entity.isCompliant,
      price: PriceModel.fromEntity(entity.price),
    );
  }
}
