import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:rebarinfo/macos-views/macos-page1.dart';
import 'package:rebarinfo/macos-views/macos-page2.dart';
import 'package:rebarinfo/macos-views/macos-page3.dart';

class MacApp extends StatelessWidget {
  const MacApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = MacosTabController(initialIndex: 0, length: 3);
    return MacosApp(
      debugShowCheckedModeBanner: false,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      home: MacosScaffold(
          toolBar: const ToolBar(
            title: Text(
              "İnşaat Demiri Hesaplamaları",
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            titleWidth: 300,
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return MacosTabView(controller: tabController, padding: const EdgeInsets.all(24), tabs: const [
                  MacosTab(label: "Ağırlık"),
                  MacosTab(label: "Çap Dönüştürme"),
                  MacosTab(label: "Donatı Seçimi")
                ], children: const [
                  MacPage1View(),
                  MacPage2View(),
                  MacPage3View()
                ]);
              },
            )
          ]),
    );
  }
}
