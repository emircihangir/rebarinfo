// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const mainApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
    SystemUiOverlay.top
  ]);
}

class mainApp extends StatelessWidget {
  const mainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Tabs(),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageView(imagePath: imagePath),
          ),
        );
      },
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PhotoView(
            imageProvider: AssetImage(imagePath),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(systemStatusBarContrastEnforced: false, systemNavigationBarContrastEnforced: false, systemNavigationBarColor: Colors.transparent, systemNavigationBarDividerColor: Colors.transparent, systemNavigationBarIconBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
          title: const TabBar(
            tabs: <Widget>[
              Tab(child: FittedBox(child: Text('Ağırlık'))),
              Tab(child: FittedBox(child: Text('Çap Dönüştürme'))),
              Tab(child: FittedBox(child: Text('Donatı Seçimi'))),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            page1(),
            page2(),
            page3(),
          ],
        ),
      ),
    );
  }
}

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  int? capDeger;
  TextEditingController uzunlukDeger = TextEditingController();
  String sonuc = '';

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

  void calculate(value) {
    (capDeger != null && uzunlukDeger.text.isNotEmpty)
        ? setState(() {
            double r = (capBirimagirlik[capDeger] ?? 0) * double.parse(uzunlukDeger.text.replaceAll(',', '.'));
            sonuc = r.toStringAsFixed(3);
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Toplam Uzunluk (m)', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    controller: uzunlukDeger,
                    onChanged: (value) {
                      if (value.contains('-') || value.contains(' ')) {
                        uzunlukDeger.text = uzunlukDeger.text.substring(0, uzunlukDeger.text.length - 1);
                      } else {
                        calculate(value);
                      }
                    },
                  ),
                ),
                DropdownButton(
                  items: const [
                    DropdownMenuItem(value: 8, child: Text('8')),
                    DropdownMenuItem(value: 10, child: Text('10')),
                    DropdownMenuItem(value: 12, child: Text('12')),
                    DropdownMenuItem(value: 14, child: Text('14')),
                    DropdownMenuItem(value: 16, child: Text('16')),
                    DropdownMenuItem(value: 18, child: Text('18')),
                    DropdownMenuItem(value: 20, child: Text('20')),
                    DropdownMenuItem(value: 22, child: Text('22')),
                    DropdownMenuItem(value: 24, child: Text('24')),
                    DropdownMenuItem(value: 26, child: Text('26')),
                    DropdownMenuItem(value: 28, child: Text('28')),
                    DropdownMenuItem(value: 28, child: Text('28')),
                    DropdownMenuItem(value: 30, child: Text('30')),
                    DropdownMenuItem(value: 32, child: Text('32')),
                    DropdownMenuItem(value: 36, child: Text('36')),
                    DropdownMenuItem(value: 40, child: Text('40')),
                    DropdownMenuItem(value: 50, child: Text('50')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      capDeger = value;
                    });
                    calculate(value);
                  },
                  hint: const Text('Çap (mm)'),
                  itemHeight: 80.0,
                  value: capDeger,
                ),
              ],
            ),
            Text(
              'Sonuç (kg): ${sonuc.replaceAll('.', ',')}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18),
            ),
            Container(margin: const EdgeInsets.only(top: 50), child: const FullScreenImage(imagePath: 'assets/page1Image.png'))
          ],
        ),
      ),
    );
  }
}

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  int? capDeger;
  TextEditingController adetDeger = TextEditingController();
  String sonuc = "";

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

  void calculate(value) {
    if (capDeger == null || adetDeger.text.isEmpty) return;

    setState(() {
      double? r;
      try {
        r = (capKesit[capDeger] ?? 0) * int.parse(adetDeger.text);
      } on FormatException {
        adetDeger.text = adetDeger.text.substring(0, adetDeger.text.length - 1);
        r = (capKesit[capDeger] ?? 0) * int.parse(adetDeger.text);
      }
      sonuc = r.toStringAsFixed(3);
    });
  }

  List<TableRow> getTableRows() {
    if (capDeger == null || adetDeger.text.isEmpty || sonuc.isEmpty) return <TableRow>[];

    List<TableRow> tr = [
      const TableRow(children: [
        Center(child: Text("Adet")),
        Center(child: Text("Çap (mm)")),
        Center(child: Text("Kesit Alanı (cm²)")),
      ])
    ];

    int counter = 0;
    for (var cap in capKesit.keys) {
      if (cap == capDeger) continue;

      double adet = double.parse(sonuc) / capKesit[cap]!;

      int newAdet = adet.ceil();

      tr.add(TableRow(decoration: BoxDecoration(color: (counter % 2 == 0) ? const Color.fromRGBO(240, 240, 240, 1) : null), children: [
        Container(alignment: Alignment.centerRight, child: Text(newAdet.toString())),
        Container(alignment: Alignment.centerRight, child: Text(cap.toString())),
        Container(alignment: Alignment.centerRight, child: Text((capKesit[cap]! * newAdet).toStringAsFixed(3).replaceAll('.', ','))),
      ]));
      counter++;
    }

    return tr;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Adet', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    controller: adetDeger,
                    onChanged: (value) {
                      if (adetDeger.text.contains('.') || adetDeger.text.contains(',')) {
                        adetDeger.text = adetDeger.text.substring(0, adetDeger.text.length - 1);

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: const Text('Adet değeri tam sayı olmalıdır.'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tamam'))
                                ],
                              );
                            });
                      } else if (adetDeger.text.contains('-') || adetDeger.text.contains(' ')) {
                        adetDeger.text = adetDeger.text.substring(0, adetDeger.text.length - 1);
                      } else {
                        calculate(value);
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(value: 8, child: Text('8')),
                      DropdownMenuItem(value: 10, child: Text('10')),
                      DropdownMenuItem(value: 12, child: Text('12')),
                      DropdownMenuItem(value: 14, child: Text('14')),
                      DropdownMenuItem(value: 16, child: Text('16')),
                      DropdownMenuItem(value: 18, child: Text('18')),
                      DropdownMenuItem(value: 20, child: Text('20')),
                      DropdownMenuItem(value: 22, child: Text('22')),
                      DropdownMenuItem(value: 24, child: Text('24')),
                      DropdownMenuItem(value: 26, child: Text('26')),
                      DropdownMenuItem(value: 28, child: Text('28')),
                      DropdownMenuItem(value: 28, child: Text('28')),
                      DropdownMenuItem(value: 30, child: Text('30')),
                      DropdownMenuItem(value: 32, child: Text('32')),
                      DropdownMenuItem(value: 36, child: Text('36')),
                      DropdownMenuItem(value: 40, child: Text('40')),
                      DropdownMenuItem(value: 50, child: Text('50')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        capDeger = value;
                      });
                      calculate(value);
                    },
                    hint: const Text('Çap (mm)'),
                    itemHeight: 80.0,
                    value: capDeger,
                  ),
                ),
              ],
            ),
            Text(
              'Kesit alanı (cm²): ${sonuc.replaceAll('.', ',')}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: Table(
                children: getTableRows(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  TextEditingController kesitAlaniDeger = TextEditingController();

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

  List<TableRow> getTableRows() {
    if (kesitAlaniDeger.text.isEmpty) return <TableRow>[];

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

      tr.add(TableRow(decoration: BoxDecoration(color: (counter % 2 == 0) ? const Color.fromRGBO(240, 240, 240, 1) : null), children: [
        Container(alignment: Alignment.centerRight, child: Text(newAdet.toString())),
        Container(alignment: Alignment.centerRight, child: Text(cap.toString())),
        Container(alignment: Alignment.centerRight, child: Text((capKesit[cap]! * newAdet).toStringAsFixed(3).replaceAll('.', ','))),
      ]));
      counter++;
    }

    return tr;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Kesit Alanı (cm²)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                controller: kesitAlaniDeger,
                onChanged: (value) {
                  if (value.contains('-') || value.contains(' ')) {
                    kesitAlaniDeger.text = kesitAlaniDeger.text.substring(0, kesitAlaniDeger.text.length - 1);
                  } else {
                    setState(() {});
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: Table(
                children: getTableRows(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
