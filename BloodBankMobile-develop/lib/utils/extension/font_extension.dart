// ignore_for_file: constant_identifier_names

enum FontFamily {
  Nunito,
}

extension FontFamilyExtension on FontFamily {
  String get name {
    switch (this) {
      case FontFamily.Nunito:
        return 'Nunito';
    }
  }
}
