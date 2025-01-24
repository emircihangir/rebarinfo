import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';
import 'package:photo_view/photo_view.dart';

class SPVpage2Model extends ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;
  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}

class Page2ResultModel extends ChangeNotifier {
  double _Page2Result = 0;
  double get Page2Result => _Page2Result;
  set Page2Result(double value) {
    _Page2Result = value;
    notifyListeners();
  }
}

class Page2View extends StatelessWidget {
  const Page2View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(child: SafeArea(child: Text("page 2")));
  }
}
