import 'package:flutter/foundation.dart';

class Logger {
  static prints(dynamic msg) {
    if (kDebugMode) {
      print(msg);
    }
  }
}
