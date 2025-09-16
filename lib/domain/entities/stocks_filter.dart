class StocksFilter {
  final String? compliance;
  final String? search;
  final String? country;

  const StocksFilter({
    this.compliance,
    this.search,
    this.country,
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};

    if (compliance != null) {
      params['filters[compliance]'] = compliance!;
    }
    if (search != null) {
      params['filters[search]'] = search!;
    }
    if (country != null) {
      params['filters[country]'] = country!;
    }

    return params;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StocksFilter &&
        other.compliance == compliance &&
        other.search == search &&
        other.country == country;
  }

  @override
  int get hashCode => compliance.hashCode ^ search.hashCode ^ country.hashCode;

  @override
  String toString() {
    return 'StocksFilter(compliance: $compliance, search: $search, country: $country)';
  }
}
