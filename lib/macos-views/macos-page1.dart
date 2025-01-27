import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MacPage1View extends StatelessWidget {
  const MacPage1View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: SizedBox(
            width: 200,
            child: MacosTextField(
              placeholder: "Toplam Uzunluk (m)",
            ),
          ),
        )
      ],
    );
  }
}
