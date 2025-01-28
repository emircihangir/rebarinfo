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

class MacPage1View extends StatelessWidget {
  const MacPage1View({super.key});

  @override
  Widget build(BuildContext context) {
    final uzunlukController = TextEditingController();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PopupModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResultModel(),
        )
      ],
      builder: (context, child) => Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: MacosTextField(
                    placeholder: "Toplam Uzunluk (m)",
                    controller: uzunlukController,
                    onChanged: (value) {
                      try {
                        final capDeger_parsed = int.parse(Provider.of<PopupModel>(context, listen: false).selectedValue.toString());
                        final uzunlukDeger_parsed = double.parse(value.replaceAll(",", "."));
                        Provider.of<ResultModel>(context, listen: false).result = page1_calculation(capDeger_parsed, uzunlukDeger_parsed);
                      } on FormatException {
                        return;
                      }
                    },
                  ),
                ),
              ),
            ),
            Consumer<PopupModel>(
              builder: (context, value, child) => SizedBox(
                width: 100,
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
                      final uzunlukDeger_parsed = double.parse(uzunlukController.text.replaceAll(",", "."));
                      Provider.of<ResultModel>(context, listen: false).result = page1_calculation(value ?? 0, uzunlukDeger_parsed);
                    } on FormatException {
                      return;
                    }
                  },
                  hint: const Text("Çap seç"),
                  value: Provider.of<PopupModel>(context, listen: false).selectedValue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ResultModel>(
                builder: (context, value, child) => Text("Sonuç: ${value.result.toStringAsFixed(2).replaceAll(".", ",")} kg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
