import 'package:flutter/material.dart';
import 'package:rebarinfo/universal-functions.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    int? capDeger;
    TextEditingController adetDeger = TextEditingController();
    String sonuc = "";
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
                      try {
                        final parsed = int.parse(adetDeger.text);
                        // setState(() => sonuc = page2_calculation(capDeger, parsed).toStringAsFixed(2).replaceAll(".", ","));
                      } on FormatException {
                        return;
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
                      try {
                        final parsed = int.parse(adetDeger.text);
                        // setState(() => sonuc = page2_calculation(capDeger, parsed).toStringAsFixed(2).replaceAll(".", ","));
                      } on FormatException {
                        return;
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
                  // children: page2_get_table_rows(capDeger, adetDeger, sonuc),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
