import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:rebarinfo/main-macos.dart';
import 'main-android.dart';
import 'main-ios.dart';
import 'package:macos_ui/macos_ui.dart';

/// This method initializes macos_window_utils and styles the window.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

void main() async {
  if (Platform.isAndroid) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
    //   SystemUiOverlay.top
    // ]);
    runApp(const AndroidApp());
  } else if (Platform.isIOS) {
    runApp(const IOSapp());
  } else if (Platform.isMacOS) {
    await _configureMacosWindowUtils();
    runApp(const MacApp());
  }
}
