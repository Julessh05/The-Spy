import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:the_spy/routing/routes.dart';

final class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _getBody(context),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: Text('Welcome'.tr()),
      automaticallyImplyLeading: false,
    );
  }

  Center _getBody(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.gameConfig),
              child: Text("New Game".tr()),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Categories".tr()),
          ),
        ],
      ),
    );
  }
}
