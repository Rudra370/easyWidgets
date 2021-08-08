
import 'dart:async';

import 'package:flutter/services.dart';

class EasyWidgetWeb {
  static const MethodChannel _channel =
      const MethodChannel('easy_widget_web');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
