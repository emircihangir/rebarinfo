import 'package:flutter/cupertino.dart';

class IOSapp extends StatelessWidget {
  const IOSapp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.circle_bottomthird_split), label: "Ağırlık"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.arrow_2_circlepath), label: "Çap Dönüştürme"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.recordingtape), label: "Donatı Seçimi"),
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
