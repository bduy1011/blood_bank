extension DoubleExt on double {
  String toStringWithInt() {
    try {
      var intV = toInt();
      if (this > intV) {
        return toString();
      }
      return intV.toString();
    } catch (e) {
      // TODO
      return toString();
    }
  }
}
