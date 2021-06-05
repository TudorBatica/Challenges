import 'routing_data.dart';

/// Routing helper methods for Strings.
extension RoutingExtension on String {
  /// Convert a string to a [RoutingData] object
  RoutingData get toRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
      queryParams: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
