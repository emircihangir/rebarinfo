// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rebarinfo/universal-functions.dart';
import 'package:provider/provider.dart';

class ResultModel extends ChangeNotifier {
  double _result = 0;
  double get result => _result;
  set result(double value) {
    _result = value;
    notifyListeners();
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController uzunlukDeger = TextEditingController();
    int? capDeger;

    return ChangeNotifierProvider(
      create: (context) => ResultModel(),
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(labelText: 'Toplam Uzunluk (m)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                controller: uzunlukDeger,
                onChanged: (value) {
                  late double _value;
                  try {
                    _value = double.parse(value.replaceAll(",", "."));
                  } on FormatException {
                    return;
                  }

                  Provider.of<ResultModel>(context, listen: false).result = page1_calculation(capDeger ?? 0, _value);
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

                  late double _parsed;
                  try {
                    _parsed = double.parse(uzunlukDeger.text.replaceAll(",", "."));
                  } on FormatException {
                    return;
                  }

                  Provider.of<ResultModel>(context, listen: false).result = page1_calculation(capDeger ?? 0, _parsed);
                },
              ),
            ),
            Consumer<ResultModel>(
              builder: (context, value, child) {
                return value.result == 0
                    ? Container()
                    : Text(
                        "Sonuç: ${value.result.toStringAsFixed(2).replaceAll(".", ",")} kg",
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
              },
            ),
            Expanded(
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                imageProvider: const AssetImage("./assets/page1Image.png"),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
