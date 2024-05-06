import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: Text('Welcome'.tr()),
      automaticallyImplyLeading: false,
    );
  }

  Widget get _body {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      verticalDirection: VerticalDirection.down,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("New Game".tr()),
        ),
      ],
    );
  }
}
