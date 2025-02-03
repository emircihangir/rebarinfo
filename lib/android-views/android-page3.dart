import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';

class TableValuesModel extends ChangeNotifier {
  List<List> _tableValues = [];
  List<List> get tableValues => _tableValues;
  set tableValues(List<List> value) {
    _tableValues = value;
    notifyListeners();
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController kesitAlaniDeger = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ChangeNotifierProvider(
        create: (context) => TableValuesModel(),
        builder: (context, child) => Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(labelText: 'Kesit Alanı (cm²)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                controller: kesitAlaniDeger,
                onChanged: (value) {
                  late double _value;
                  try {
                    _value = double.parse(value.replaceAll(",", "."));
                  } on FormatException {
                    return;
                  }

                  Provider.of<TableValuesModel>(context, listen: false).tableValues = page3_calculate_table_values(_value);
                },
              ),
            ),
            const SizedBox(
              height: 16,
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
                            color: (index % 2 == 0) ? const Color.fromARGB(50, 128, 128, 128) : Colors.transparent,
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
