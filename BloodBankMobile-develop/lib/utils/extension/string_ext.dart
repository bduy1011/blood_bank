import '../remove_diacritic.dart';

extension StringExt on String {
  String get nameAlias {
    return removeDiacritics(this).toUpperCase();
  }

  int? get toIntOrNull {
    try {
      return int.parse(trim());
    } catch (e) {
      return null;
    }
  }

  int? get toIntOrZero {
    try {
      return int.parse(trim());
    } catch (e) {
      return 0;
    }
  }
}
