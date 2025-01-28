import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';

class PopupModel extends ChangeNotifier {
  int? _selectedValue;
  int? get selectedValue => _selectedValue;
  set selectedValue(int? value) {
    _selectedValue = value;
    notifyListeners();
  }
}

class ResultModel extends ChangeNotifier {
  double _result = 0;
  double get result => _result;
  set result(double value) {
    _result = value;
    notifyListeners();
  }
}

class TableValuesModel extends ChangeNotifier {
  List<List>? _tableValues;
  List<List>? get tableValues => _tableValues;
  set tableValues(List<List>? value) {
    _tableValues = value;
    notifyListeners();
  }
}

class MacPage2View extends StatelessWidget {
  const MacPage2View({super.key});

  @override
  Widget build(BuildContext context) {
    final adetController = TextEditingController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PopupModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResultModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableValuesModel(),
        )
      ],
      builder: (context, child) => Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 150,
                child: MacosTextField(
                  placeholder: "Adet",
                  controller: adetController,
                  onChanged: (value) {
                    try {
                      final capDeger_parsed = int.parse(Provider.of<PopupModel>(context, listen: false).selectedValue.toString());
                      final adetDeger_parsed = int.parse(value);
                      final calculation = page2_calculation(capDeger_parsed, adetDeger_parsed);
                      Provider.of<ResultModel>(context, listen: false).result = calculation;
                      Provider.of<TableValuesModel>(context, listen: false).tableValues = page2_calculate_table_values(capDeger_parsed, adetDeger_parsed, calculation);
                    } on FormatException {
                      return;
                    }
                  },
                ),
              ),
            ),
          ),
          Consumer<PopupModel>(
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 140,
                child: MacosPopupButton(
                  items: capPickerValues
                      .map(
                        (e) => MacosPopupMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    Provider.of<PopupModel>(context, listen: false).selectedValue = value;
                    print(value.runtimeType);

                    try {
                      final adetDeger_parsed = int.parse(adetController.text);
                      final calculation = page2_calculation(value ?? 0, adetDeger_parsed);
                      Provider.of<ResultModel>(context, listen: false).result = calculation;

                      if (value != null) {
                        Provider.of<TableValuesModel>(context, listen: false).tableValues = page2_calculate_table_values(value, adetDeger_parsed, calculation);
                      }
                    } on FormatException {
                      return;
                    }
                  },
                  hint: const Text("Çap seç (mm)"),
                  value: Provider.of<PopupModel>(context, listen: false).selectedValue,
                ),
              ),
            ),
          ),
          Consumer<ResultModel>(
            builder: (context, value, child) => Text("Kesit alanı: ${value.result.toStringAsFixed(2).replaceAll(".", ",")} cm²"),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Consumer<TableValuesModel>(
                builder: (context, value, child) => ListView.builder(
                    itemCount: (value.tableValues?.length ?? -1) + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const ColoredBox(
                          color: MacosColors.tertiaryLabelColor,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Adet",
                                textAlign: TextAlign.center,
                              )),
                              Expanded(child: Text("Çap (mm)", textAlign: TextAlign.center)),
                              Expanded(child: Text("Kesit Alanı (cm²)", textAlign: TextAlign.right))
                            ],
                          ),
                        );
                      } else {
                        return ColoredBox(
                          color: (index % 2) == 0 ? MacosColors.tertiaryLabelColor : MacosColors.transparent,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                value.tableValues?[index - 1][0].toString() ?? "",
                                textAlign: TextAlign.center,
                              )),
                              Expanded(child: Text(value.tableValues?[index - 1][1].toString() ?? "", textAlign: TextAlign.center)),
                              Expanded(child: Text(value.tableValues?[index - 1][2].toStringAsFixed(2).replaceAll(".", ",") ?? "", textAlign: TextAlign.right))
                            ],
                          ),
                        );
                      }
                    })),
          )
        ],
      ),
    );
  }
}
