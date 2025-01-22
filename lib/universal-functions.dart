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

String page1_calculation(capDeger, uzunlukDeger) {
  double r = (capBirimagirlik[capDeger] ?? 0) * double.parse(uzunlukDeger.text);
  return r.toStringAsFixed(3).replaceAll(".", ",");
}
