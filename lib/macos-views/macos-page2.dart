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
                      Provider.of<ResultModel>(context, listen: false).result = page2_calculation(capDeger_parsed, adetDeger_parsed);
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

                    try {
                      final adetDeger_parsed = int.parse(adetController.text);
                      Provider.of<ResultModel>(context, listen: false).result = page2_calculation(value ?? 0, adetDeger_parsed);
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
          )
        ],
      ),
    );
  }
}
