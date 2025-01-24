import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';
import 'package:photo_view/photo_view.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CupertinoTextField(
                  textAlign: TextAlign.center,
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
                    } on FormatException {
                      return;
                    }
                  },
                ),
              ),
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
                                } on FormatException {
                                  return;
                                }
                              },
                              children: pickerValues.map((e) => Text("${e}mm")).toList()),
                        ),
                      );
                    },
                  );
                }),
            Consumer<ResultModel>(
              builder: (context, value, child) => value._result == "" ? const Text("") : Text("Sonuç: ${value._result}kg"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: CupertinoColors.systemBackground),
                imageProvider: const AssetImage("./assets/page1Image.png"),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered,
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
