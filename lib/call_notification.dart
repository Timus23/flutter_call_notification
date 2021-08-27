
import 'dart:async';

import 'package:flutter/services.dart';

class CallNotification {
  static const MethodChannel _channel =
      const MethodChannel('call_notification');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
