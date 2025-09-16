class PaginationParams {
  final int page;
  final int perPage;

  const PaginationParams({
    this.page = 1,
    this.perPage = 20,
  });

  Map<String, String> toQueryParams() {
    return {
      'pagination[page]': page.toString(),
      'pagination[perPage]': perPage.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginationParams &&
        other.page == page &&
        other.perPage == perPage;
  }

  @override
  int get hashCode => page.hashCode ^ perPage.hashCode;

  @override
  String toString() => 'PaginationParams(page: $page, perPage: $perPage)';
}
