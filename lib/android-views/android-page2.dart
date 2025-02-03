// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:rebarinfo/universal-functions.dart';
import 'package:provider/provider.dart';

class ResultsModel extends ChangeNotifier {
  double _calculation_result = 0;
  double get calculation_result => _calculation_result;
  set calculation_result(double value) {
    _calculation_result = value;
    notifyListeners();
  }

  List<List> _tableValues = [];
  List<List> get tableValues => _tableValues;
  set tableValues(List<List> value) {
    _tableValues = value;
    notifyListeners();
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    int? capDeger;
    TextEditingController adetDeger = TextEditingController();

    return ChangeNotifierProvider(
      create: (context) => ResultsModel(),
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(labelText: 'Adet', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                controller: adetDeger,
                onChanged: (value) {
                  late int _value;
                  try {
                    _value = int.parse(value);
                  } on FormatException {
                    return;
                  }

                  Provider.of<ResultsModel>(context, listen: false).calculation_result = page2_calculation(capDeger ?? 0, _value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: DropdownMenu(
                menuHeight: 200,
                dropdownMenuEntries: capPickerValues
                    .map(
                      (e) => DropdownMenuEntry(value: e, label: e.toString()),
                    )
                    .toList(),
                label: const Text("Çap (mm)"),
                width: 200,
                onSelected: (value) {
                  capDeger = value;

                  late int _parsed;
                  try {
                    _parsed = int.parse(adetDeger.text);
                  } on FormatException {
                    return;
                  }

                  double calculation = page2_calculation(capDeger ?? 0, _parsed);

                  Provider.of<ResultsModel>(context, listen: false).calculation_result = calculation;
                  Provider.of<ResultsModel>(context, listen: false).tableValues = page2_calculate_table_values(capDeger ?? 0, _parsed, calculation);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Consumer<ResultsModel>(
                builder: (context, value, child) {
                  return value.calculation_result == 0
                      ? Container()
                      : Text(
                          "Kesit alanı: ${value.calculation_result.toStringAsFixed(2).replaceAll(".", ",")} m²",
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                },
              ),
            ),
            Expanded(
              child: Consumer<ResultsModel>(
                builder: (context, value, child) {
                  if (value.tableValues.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value.tableValues.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ColoredBox(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: const Row(
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
                            color: (index % 2 == 0) ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
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
      ),
    );
  }
}
