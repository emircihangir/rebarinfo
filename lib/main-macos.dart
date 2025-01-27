import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MacApp extends StatelessWidget {
  const MacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MacosApp(
      home: Placeholder(
        child: Text("Mac App"),
      ),
    );
  }
}
