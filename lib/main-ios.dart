import 'package:flutter/cupertino.dart';
import 'ios-views/page1.dart';
import 'ios-views/page2.dart';
import 'ios-views/page3.dart';

class IOSapp extends StatelessWidget {
  const IOSapp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
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
