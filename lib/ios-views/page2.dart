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
    final adetController = TextEditingController();
    final textFieldFocusNode = FocusNode();

    return CupertinoPageScaffold(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedValueModel()),
        ChangeNotifierProvider(create: (context) => ResultModel())
      ],
      builder: (context, child) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CupertinoTextField(
                  placeholder: "Adet",
                  controller: adetController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  focusNode: textFieldFocusNode,
                  onTapOutside: (event) => textFieldFocusNode.unfocus(),
                ),
              ),
            ),
            CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Consumer<SelectedValueModel>(
                  builder: (context, value, child) => Text(
                    value.selectedValue == 0 ? "Çap seç" : "Çap: ${"${value.selectedValue}mm"}",
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
                                Provider.of<SelectedValueModel>(context, listen: false).selectedValue = capPickerValues[selectedIndex];

                                try {
                                  final parsed = double.parse(adetController.text);
                                  Provider.of<ResultModel>(context, listen: false).Result = page1_calculation(Provider.of<SelectedValueModel>(context, listen: false)._selectedValue, parsed);
                                } on FormatException {
                                  return;
                                }
                              },
                              children: capPickerValues.map((e) => Text("${e}mm")).toList()),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      )),
    ));
  }
}
