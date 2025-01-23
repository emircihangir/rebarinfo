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
                      if (capDeger == null || uzunlukDeger.text.isEmpty) return;

                      try {
                        final parsed = double.parse(uzunlukDeger.text);
                        setState(() => sonuc = page1_calculation(capDeger!, parsed));
                      } on FormatException {}
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
                    DropdownMenuItem(value: 30, child: Text('30')),
                    DropdownMenuItem(value: 32, child: Text('32')),
                    DropdownMenuItem(value: 36, child: Text('36')),
                    DropdownMenuItem(value: 40, child: Text('40')),
                    DropdownMenuItem(value: 50, child: Text('50')),
                  ],
                  onChanged: (value) {
                    capDeger = value;
                    if (capDeger == null || uzunlukDeger.text.isEmpty) return;

                    try {
                      final parsed = double.parse(uzunlukDeger.text);
                      setState(() => sonuc = page1_calculation(capDeger!, parsed));
                    } on FormatException {}
                  },
                  hint: const Text('Çap (mm)'),
                  itemHeight: 80.0,
                  value: capDeger,
                ),
              ],
            ),
            Text(
              'Sonuç (kg): $sonuc',
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
                      if (capDeger != null && adetDeger.text.isNotEmpty) {
                        setState(() => sonuc = page2_calculation(capDeger, adetDeger));
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
                      capDeger = value;
                      if (capDeger != null && adetDeger.text.isNotEmpty) {
                        setState(() => sonuc = page2_calculation(capDeger, adetDeger));
                      }
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
                children: page2_get_table_rows(capDeger, adetDeger, sonuc),
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
                  try {
                    double.parse(kesitAlaniDeger.text.replaceAll(',', '.'));
                    setState(() {});
                  } on FormatException {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Geçersiz değer.")));
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: Table(
                children: page3_get_table_rows(kesitAlaniDeger),
              ),
            )
          ],
        ),
      ),
    );
  }
}
