import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';

class SelectedValueModel extends ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;
  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}

class ResultModel extends ChangeNotifier {
  String _Result = "";
  String get Result => _Result;
  set Result(String value) {
    _Result = value;
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
