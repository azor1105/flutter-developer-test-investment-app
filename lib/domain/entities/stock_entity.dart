import 'price_entity.dart';

class StockEntity {
  final int id;
  final String companyName;
  final String tradingSymbol;
  final String logo;
  final String currency;
  final bool shariahCheck;
  final DateTime analysisDate;
  final bool isCompliant;
  final PriceEntity price;

  const StockEntity({
    required this.id,
    required this.companyName,
    required this.tradingSymbol,
    required this.logo,
    required this.currency,
    required this.shariahCheck,
    required this.analysisDate,
    required this.isCompliant,
    required this.price,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StockEntity &&
        other.id == id &&
        other.companyName == companyName &&
        other.tradingSymbol == tradingSymbol &&
        other.logo == logo &&
        other.currency == currency &&
        other.shariahCheck == shariahCheck &&
        other.analysisDate == analysisDate &&
        other.isCompliant == isCompliant &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        tradingSymbol.hashCode ^
        logo.hashCode ^
        currency.hashCode ^
        shariahCheck.hashCode ^
        analysisDate.hashCode ^
        isCompliant.hashCode ^
        price.hashCode;
  }

  @override
  String toString() {
    return 'StockEntity(id: $id, companyName: $companyName, tradingSymbol: $tradingSymbol, logo: $logo, currency: $currency, shariahCheck: $shariahCheck, analysisDate: $analysisDate, isCompliant: $isCompliant, price: $price)';
  }
}
