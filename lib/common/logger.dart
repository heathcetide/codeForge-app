import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
  );

  static void log(String message) {
    _logger.i(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void verbose(String message) {
    _logger.v(message);
  }
}
