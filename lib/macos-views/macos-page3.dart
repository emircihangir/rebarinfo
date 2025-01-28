import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:rebarinfo/universal-functions.dart';

class TableValuesModel extends ChangeNotifier {
  List<List>? _tableValues;
  List<List>? get tableValues => _tableValues;
  set tableValues(List<List>? value) {
    _tableValues = value;
    notifyListeners();
  }
}

class MacPage3View extends StatelessWidget {
  const MacPage3View({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TableValuesModel(),
      builder: (context, child) => Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 150,
                child: MacosTextField(
                  placeholder: "Kesit Alanı (cm²)",
                  onChanged: (value) {
                    try {
                      final kesitAlani_parsed = double.parse(value.replaceAll(",", "."));
                      Provider.of<TableValuesModel>(context, listen: false).tableValues = page3_calculate_table_values(kesitAlani_parsed);
                    } on FormatException {
                      return;
                    }
                  },
                ),
              ),
            ),
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
