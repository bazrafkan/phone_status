import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _phoneStateEventChannel = EventChannel('phone_status');
Stream<PhoneStatus> _phoneStateEvent;


class PhoneStatus {
  final String state;
  PhoneStatus(this.state);

  @override
  String toString() => '$state';
}

PhoneStatus _listphoneStateEvent(String state) {
  return new PhoneStatus(state);
}

/// A broadcast stream of events from the phone state.
Stream<PhoneStatus> get phoneStateEvent {
  if (_phoneStateEvent == null) {
    _phoneStateEvent = _phoneStateEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listphoneStateEvent(event));
  }
  return _phoneStateEvent;
}

