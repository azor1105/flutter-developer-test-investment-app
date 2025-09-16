class PriceEntity {
  final double price;
  final double changePercent;

  const PriceEntity({
    required this.price,
    required this.changePercent,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PriceEntity &&
        other.price == price &&
        other.changePercent == changePercent;
  }

  @override
  int get hashCode => price.hashCode ^ changePercent.hashCode;

  @override
  String toString() {
    return 'PriceEntity(price: $price, changePercent: $changePercent)';
  }
}
