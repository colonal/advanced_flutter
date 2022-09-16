import 'constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    return this ?? Constants.empty;
  }
}

extension NonNullInt on int? {
  int orZero() {
    return this ?? Constants.zero;
  }
}
