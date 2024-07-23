//
double betterParseDouble(dynamic value, {double defaultValue = 0.0}) {
  if (value is double) return value;

  if (value is String) return double.tryParse(value) ?? defaultValue;

  if (value is int) return value.toDouble();

  return defaultValue;
}
