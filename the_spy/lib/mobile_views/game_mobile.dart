import 'dart:convert';
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

  String _word = "";

  bool _hidden = true;

  @override
  void initState() {
    final Random rm = Random();
    for (int i = 0; i < widget.numberSpies; i++) {
      _spyNumbers.add(rm.nextInt(widget.numberPlayer) + 1);
    }
    _loadWord();
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
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            position: DecorationPosition.background,
            child: Center(child: Text(_cardText)),
          ),
        ),
      ),
    );
  }

  void _loadWord() async {
    // TODO: change 10 to number of files
    final int categoryNumber = Random().nextInt(10);
    // Load File at the index of [category Number]
    final String data =
        await DefaultAssetBundle.of(context).loadString("data/words.json");
    // Get File as String and get single word
    jsonDecode(data);
    // Assign word to _word
    _word = "Loaded Word";
  }
}
