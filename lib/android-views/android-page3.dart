import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController kesitAlaniDeger = TextEditingController();

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
                    // setState(() {});
                  } on FormatException {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Geçersiz değer.")));
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 8, right: 8),
              child: Table(
                  // children: page3_get_table_rows(kesitAlaniDeger),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
