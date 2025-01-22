import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'universal-functions.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

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
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int? capDeger;
  TextEditingController uzunlukDeger = TextEditingController();
  String sonuc = '';

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
                      } else if (capDeger != null && uzunlukDeger.text.isNotEmpty) {
                        setState(() => sonuc = page1_calculation(capDeger, uzunlukDeger));
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
                    capDeger = value;
                    if (capDeger != null && uzunlukDeger.text.isNotEmpty) {
                      setState(() => sonuc = page1_calculation(capDeger, uzunlukDeger));
                    }
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

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
