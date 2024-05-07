import 'dart:math';

import 'package:flutter/material.dart';

class GameMobile extends StatefulWidget {
  const GameMobile({
    super.key,
    required this.numberPlayer,
    required this.numberSpies,
  });

  final int numberPlayer;

  final int numberSpies;

  @override
  State<GameMobile> createState() => _GameMobileState();
}

class _GameMobileState extends State<GameMobile> {
  final List<int> _spyNumbers = [];

  int _playerCounter = 1;

  String _cardText = "Tap to show";

  final String _word = "Test Word"; // TODO: change to loaded word

  bool _hidden = true;

  @override
  void initState() {
    final Random rm = Random();
    for (int i = 0; i < widget.numberSpies; i++) {
      _spyNumbers.add(rm.nextInt(widget.numberPlayer) + 1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  AppBar get _appBar {
    return AppBar();
  }

  Center get _body {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_hidden) {
              if (_spyNumbers.contains(_playerCounter)) {
                _cardText = "You're a spy";
              } else {
                _cardText = _word;
              }
              _playerCounter++;
              _hidden = false;
            } else {
              _cardText = "Tap to show";
              _hidden = true;
            }
          });
        },
        child: SizedBox(
          height: size.height / 2,
          width: size.width / 1.25,
          child: DecoratedBox(
            decoration: const BoxDecoration(),
            position: DecorationPosition.background,
            child: Text(_cardText),
          ),
        ),
      ),
    );
  }
}
