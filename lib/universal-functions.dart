Map<int, double> capBirimagirlik = {
  8: 0.395,
  10: 0.617,
  12: 0.888,
  14: 1.21,
  16: 1.58,
  18: 2,
  20: 2.47,
  22: 2.985,
  24: 3.55,
  26: 4.168,
  28: 4.83,
  30: 5.55,
  32: 6.31,
  36: 7.99,
  40: 9.86,
  50: 15.4
};

Map<int, double> capKesit = {
  8: 0.5,
  10: 0.79,
  12: 1.13,
  14: 1.54,
  16: 2.01,
  18: 2.54,
  20: 3.14,
  22: 3.8,
  24: 4.52,
  26: 5.31,
  28: 6.16,
  30: 7.07,
  32: 8.04,
  36: 10.18,
  40: 12.57,
  50: 19.64
};

const capPickerValues = [
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

double page1_calculation(int capDeger, double uzunlukDeger) => (capBirimagirlik[capDeger] ?? 0) * uzunlukDeger;

double page2_calculation(int? capDeger, int adetDeger) => (capKesit[capDeger] ?? 0) * adetDeger;

List<TableRow> page3_get_table_rows(kesitAlaniDeger) {
  if (kesitAlaniDeger.text.isEmpty) return [];

  List<TableRow> tr = [
    const TableRow(children: [
      Center(child: Text("Adet")),
      Center(child: Text("Çap (mm)")),
      Center(child: Text("Kesit Alanı (cm²)")),
    ])
  ];

  int counter = 0;
  for (var cap in capKesit.keys) {
    double adet = double.parse(kesitAlaniDeger.text.replaceAll(',', '.')) / capKesit[cap]!;

    int newAdet = adet.ceil();

    tr.add(TableRow(decoration: BoxDecoration(color: (counter % 2 == 0) ? ThemeData().primaryColor.withAlpha(25) : null), children: [
      Container(alignment: Alignment.centerRight, child: Text(newAdet.toString())),
      Container(alignment: Alignment.centerRight, child: Text(cap.toString())),
      Container(alignment: Alignment.centerRight, child: Text((capKesit[cap]! * newAdet).toStringAsFixed(2).replaceAll('.', ','))),
    ]));
    counter++;
  }

  return tr;
}

List<List> page2_calculate_table_values(int capDeger, int adetDeger, double sonuc) {
  // if (capDeger == null || adetDeger == null || sonuc.isEmpty) return [];

  List<List> result = [];
  for (var cap in capKesit.keys) {
    if (cap == capDeger) continue;

    int adet = (sonuc / capKesit[cap]!).ceil();

    result.add([
      adet,
      cap,
      (capKesit[cap]! * adet)
    ]);
  }

  return result;
}
