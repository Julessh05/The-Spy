import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:string_translate/string_translate.dart' show Translate;
import 'package:the_spy/routing/routes.dart';

class GameConfigMobile extends StatefulWidget {
  const GameConfigMobile({super.key});

  @override
  State<GameConfigMobile> createState() => _GameConfigMobileState();
}

class _GameConfigMobileState extends State<GameConfigMobile> {
  int _numberPlayer = 2;

  int _numberSpies = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _getBody(context),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: Text("Game Settings".tr()),
    );
  }

  Widget _getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            autocorrect: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: TextEditingController(text: _numberPlayer.toString()),
            decoration: InputDecoration(
              labelText: "Number of Players:".tr(),
            ),
            onChanged: (n) {
              setState(() {
                _numberPlayer = int.parse(n);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            autocorrect: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: TextEditingController(text: _numberSpies.toString()),
            decoration: InputDecoration(
              labelText: "Number of Spies:".tr(),
            ),
            onChanged: (n) {
              setState(() {
                _numberSpies = int.parse(n);
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => (_numberPlayer > 0 &&
                  _numberSpies > 0 &&
                  _numberPlayer > _numberSpies)
              ? Navigator.pushReplacementNamed(
                  context,
                  Routes.game,
                )
              : null,
          child: Text("Start".tr()),
        )
      ],
    );
  }
}
