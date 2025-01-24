import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';
import 'package:photo_view/photo_view.dart';

class Page3View extends StatelessWidget {
  const Page3View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(child: SafeArea(child: Text("page 3")));
  }
}
