import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String _result = "";
  String get result => _result;
  set result(String value) {
    _result = value;
    notifyListeners();
  }
}

class TableValuesModel extends ChangeNotifier {
  List<List> _tableValues = [];
  List<List> get tableValues => _tableValues;
  set tableValues(List<List> value) {
    _tableValues = value;
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
        ChangeNotifierProvider(create: (context) => ResultModel()),
        ChangeNotifierProvider(
          create: (context) => TableValuesModel(),
        )
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
                  onChanged: (value) {
                    //* Update the result state
                    try {
                      final parsed = int.parse(adetController.text);
                      double sonuc = page2_calculation(Provider.of<SelectedValueModel>(context, listen: false).selectedValue, parsed);
                      Provider.of<ResultModel>(context, listen: false).result = sonuc.toStringAsFixed(2).replaceAll(".", ",");
                      Provider.of<TableValuesModel>(context, listen: false).tableValues = page2_calculate_table_values(Provider.of<SelectedValueModel>(context, listen: false).selectedValue, parsed, sonuc);
                    } on FormatException {
                      return;
                    }
                  },
                ),
              ),
            ),
            CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Consumer<SelectedValueModel>(
                  builder: (context, value, child) => Text(
                    value.selectedValue == 0 ? "Çap seç" : "Çap: ${"${value.selectedValue} mm"}",
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
                                  final parsed = int.parse(adetController.text);
                                  final sonuc = page2_calculation(capPickerValues[selectedIndex], parsed);
                                  Provider.of<ResultModel>(context, listen: false).result = sonuc.toStringAsFixed(2).replaceAll(".", ",");
                                  Provider.of<TableValuesModel>(context, listen: false).tableValues = page2_calculate_table_values(capPickerValues[selectedIndex], parsed, sonuc);
                                } on FormatException {
                                  return;
                                }
                              },
                              children: capPickerValues.map((e) => Text("$e mm")).toList()),
                        ),
                      );
                    },
                  );
                }),
            Consumer<ResultModel>(
              builder: (context, value, child) => value._result == "" ? const Text("") : Text("Kesit alanı: ${value._result} cm²"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<TableValuesModel>(
                builder: (context, value, child) {
                  if (value.tableValues.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value.tableValues.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const ColoredBox(
                            color: Color.fromARGB(50, 128, 128, 128),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Adet",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "Çap (mm)",
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                    child: Text(
                                  "Kesit Alanı (cm²)",
                                  textAlign: TextAlign.right,
                                ))
                              ],
                            ),
                          );
                        } else {
                          return ColoredBox(
                            color: (index % 2 == 0) ? Color.fromARGB(50, 128, 128, 128) : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    value.tableValues[index - 1][0].toString().replaceAll(".", ","),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  value.tableValues[index - 1][1].toString().replaceAll(".", ","),
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                    child: Text(
                                  value.tableValues[index - 1][2].toStringAsFixed(2).replaceAll(".", ","),
                                  textAlign: TextAlign.right,
                                ))
                              ],
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      )),
    ));
  }
}
