/// Models the route and the query parameters of a path
class RoutingData {
  /// Base path
  final String route;

  /// All query parameters and their values
  final Map<String, String> queryParams;

  // ignore: public_member_api_docs
  RoutingData({required this.route, required this.queryParams});

  /// Look up a query parameter's value
  String? operator [](String key) => queryParams[key];
}
