import 'package:flutter/cupertino.dart';

class IOSapp extends StatelessWidget {
  const IOSapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        child: Center(
          child: Text("IOS app"),
        ),
      ),
    );
  }
}
