import 'dart:async';
import 'dart:io';

import 'package:call_notification/call_defination.dart';
import 'package:call_notification/model/call_notification_data.dart';
import 'package:call_notification/model/received_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class CallNotification {
  static const MethodChannel _channel =
      const MethodChannel('call_notification');

  static final CallNotification _callNotification =
      CallNotification._internal();

  factory CallNotification() {
    return _callNotification;
  }

  CallNotification._internal();

  final BehaviorSubject<NotificationReceivedAction>
      // ignore: close_sinks
      _actionSubject = BehaviorSubject<NotificationReceivedAction>();

  /// Stream to capture all actions (tap) over notifications
  BehaviorSubject<NotificationReceivedAction> get actionStream {
    return _actionSubject;
  }

  dispose() {
    _actionSubject.close();
  }

  initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    _channel.setMethodCallHandler(_handleMethod);
    _channel.invokeMethod("showUnhandledPressedAction");
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    Map<String, dynamic> arguments = Map<String, dynamic>.from(call.arguments);
    switch (call.method) {
      case CallDefications.CHANNEL_METHOD_ACTION_RECEIVED:
        {
          _actionSubject.add(NotificationReceivedAction.fromJson(
              Map<String, dynamic>.from(arguments)));
          return;
        }

      default:
        throw UnsupportedError('Unrecognized JSON message');
    }
  }

  showNotification({required CallNotificationData callNotificationData}) async {
    await _channel.invokeMethod(
        'showNotification', callNotificationData.toJson());
  }

  cancelCallNotification() async {
    await _channel.invokeMethod('cancelCallNotification');
  }

  Future<bool> get isNotificationEnabled async {
    if (Platform.isAndroid) {
      final res =
          (await _channel.invokeMethod('isNotificationEnabled')) as bool;
      return res;
    } else {
      return false;
    }
  }
}
