import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'android-views/android-page1.dart';
import 'android-views/android-page2.dart';
import 'android-views/android-page3.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), scaffoldBackgroundColor: Colors.white, appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(systemStatusBarContrastEnforced: false, systemNavigationBarContrastEnforced: false, systemNavigationBarColor: Colors.transparent, systemNavigationBarDividerColor: Colors.transparent, systemNavigationBarIconBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
            title: const TabBar(
              tabs: <Widget>[
                Tab(child: FittedBox(child: Text('Ağırlık'))),
                Tab(child: FittedBox(child: Text('Çap Dönüştürme'))),
                Tab(child: FittedBox(child: Text('Donatı Seçimi'))),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
        ),
      ),
    );
  }
}
