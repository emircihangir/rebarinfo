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

String page1_calculation(capDeger, uzunlukDeger) {
  double r = (capBirimagirlik[capDeger] ?? 0) * double.parse(uzunlukDeger.text);
  return r.toStringAsFixed(3).replaceAll(".", ",");
}

String page2_calculation(capDeger, adetDeger) {
  double? r;
  try {
    r = (capKesit[capDeger] ?? 0) * int.parse(adetDeger.text);
  } on FormatException {
    adetDeger.text = adetDeger.text.substring(0, adetDeger.text.length - 1);
    r = (capKesit[capDeger] ?? 0) * int.parse(adetDeger.text);
  }
  return r.toStringAsFixed(3);
}
