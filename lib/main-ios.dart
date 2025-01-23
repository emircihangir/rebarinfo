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
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();

    const pickerValues = [
      8,
      10,
      12,
      14,
      16,
      18,
      20,
      22,
      24,
      26,
      28,
      28,
      30,
      32,
      36,
      40,
      50
    ];

    return CupertinoPageScaffold(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedPickerValueModel()),
        ChangeNotifierProvider(create: (context) => ResultModel()),
      ],
      builder: (context, child) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CupertinoTextField(
              maxLength: 3,
              focusNode: focusNode,
              onTapOutside: (event) => focusNode.unfocus(),
              controller: controller,
              placeholder: "Toplam Uzunluk (m)",
              keyboardType: TextInputType.number,
              onChanged: (value) {
                //* Update the result state
                try {
                  final parsed = double.parse(controller.text);
                  Provider.of<ResultModel>(context, listen: false).result = page1_calculation(Provider.of<SelectedPickerValueModel>(context, listen: false)._selectedPickerValue, parsed);
                } on FormatException {}
              },
            ),
            CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Consumer<SelectedPickerValueModel>(
                  builder: (context, value, child) => Text(
                    value.selectedPickerValue == 0 ? "Çap seç" : "Çap: ${"${value.selectedPickerValue}mm"}",
                    textAlign: TextAlign.left,
                  ),
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (c) {
                      return Container(
                        height: 216,
                        padding: const EdgeInsets.only(top: 6.0),
                        // The Bottom margin is provided to align the popup above the system navigation bar.
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        // Provide a background color for the popup.
                        color: CupertinoColors.systemBackground.resolveFrom(context),
                        // Use a SafeArea widget to avoid system overlaps.
                        child: SafeArea(
                          top: false,
                          child: CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32,
                              onSelectedItemChanged: (selectedIndex) {
                                Provider.of<SelectedPickerValueModel>(context, listen: false).selectedPickerValue = pickerValues[selectedIndex];

                                try {
                                  final parsed = double.parse(controller.text);
                                  Provider.of<ResultModel>(context, listen: false).result = page1_calculation(Provider.of<SelectedPickerValueModel>(context, listen: false)._selectedPickerValue, parsed);
                                } on FormatException {}
                              },
                              children: pickerValues.map((e) => Text("${e}mm")).toList()),
                        ),
                      );
                    },
                  );
                }),
            Consumer<ResultModel>(
              builder: (context, value, child) => value._result == "" ? const Text("") : Text("Sonuç: ${value._result}kg"),
            )
          ],
        ),
      )),
    ));
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
