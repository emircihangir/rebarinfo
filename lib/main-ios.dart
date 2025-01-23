import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';

class IOSapp extends StatelessWidget {
  const IOSapp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              "./assets/weight.png",
              color: CupertinoColors.systemGrey,
            ),
            activeIcon: Image.asset(
              "./assets/weight.png",
              color: CupertinoColors.activeBlue,
            ),
            label: "Ağırlık"),
        const BottomNavigationBarItem(icon: Icon(CupertinoIcons.arrow_2_circlepath), label: "Çap Dönüştürme"),
        BottomNavigationBarItem(
            icon: Image.asset(
              "./assets/steel.png",
              color: CupertinoColors.systemGrey,
            ),
            activeIcon: Image.asset(
              "./assets/steel.png",
              color: CupertinoColors.activeBlue,
            ),
            label: "Donatı Seçimi"),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Page1View();
          case 1:
            return const Page2View();
          case 2:
            return const Page3View();

          default:
            return const Page1View();
        }
      },
    ));
  }
}

class SelectedPickerValueModel extends ChangeNotifier {
  int _selectedPickerValue = 0;

  int get selectedPickerValue => _selectedPickerValue;

  set selectedPickerValue(int value) {
    _selectedPickerValue = value;
    notifyListeners();
  }
}

class ResultModel extends ChangeNotifier {
  String _result = "";

  set result(String value) {
    _result = value;
    notifyListeners();
  }
}

class Page1View extends StatelessWidget {
  const Page1View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(child: SafeArea(child: Text("page 1")));
  }
}

class Page2View extends StatelessWidget {
  const Page2View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(child: SafeArea(child: Text("page 2")));
  }
}

class Page3View extends StatelessWidget {
  const Page3View({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(child: SafeArea(child: Text("page 3")));
  }
}
