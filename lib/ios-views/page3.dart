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
    final textFieldFocusNode = FocusNode();
    final textFieldController = TextEditingController();

    return CupertinoPageScaffold(
        child: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChangeNotifierProvider(
        create: (context) => TableValuesModel(),
        builder: (context, child) => Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CupertinoTextField(
                  placeholder: "Kesit Alanı (cm²)",
                  controller: textFieldController,
                  textAlign: TextAlign.center,
                  focusNode: textFieldFocusNode,
                  onTapOutside: (event) => textFieldFocusNode.unfocus(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
