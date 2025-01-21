import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main-android.dart';
import 'main-ios.dart';

void main() {
  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
      SystemUiOverlay.top
    ]);
    runApp(const AndroidApp());
  } else if (Platform.isIOS) {
    runApp(const IOSapp());
  }
}
