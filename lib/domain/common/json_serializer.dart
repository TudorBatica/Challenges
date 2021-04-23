import 'package:injectable/injectable.dart';

/// JSON to/from entity serializer
abstract class JsonSerializer<T> {
  /// Get JSON representation
  Map<String, dynamic> toJson(T instance);

  /// Create entity from JSON
  T fromJson(Map<String, dynamic> json);
}
