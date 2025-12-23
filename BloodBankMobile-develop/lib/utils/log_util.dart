import 'package:logger/logger.dart';

class LogUtil {
  static final logger = Logger(
    filter: null,
    printer: PrettyPrinter(
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static log() {}

  static createCubitAndState(C, S) {
    logger.i('Create ${C.toString()} with ${S.toString()}');
  }

  static deleteCubitAndState(C, S) {
    logger.i('Delete ${C.toString()} with ${S.toString()}');
  }
}
