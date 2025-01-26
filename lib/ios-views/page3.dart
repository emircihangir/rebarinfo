import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rebarinfo/universal-functions.dart';

class TableValuesModel extends ChangeNotifier {
  List<List> _tableValues = [];
  List<List> get tableValues => _tableValues;
  set tableValues(List<List> value) {
    _tableValues = value;
    notifyListeners();
  }
}

class Page3View extends StatelessWidget {
  const Page3View({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    final focusNode = FocusNode();

    return CupertinoPageScaffold(
        child: SafeArea(
            child: Column(
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: CupertinoTextField(
              placeholder: "Kesit Alanı (cm²)",
              focusNode: focusNode,
              onTapOutside: (event) => focusNode.unfocus(),
              controller: textFieldController,
              onChanged: (value) {},
            ),
          ),
        )
      ],
    )));
  }
}
