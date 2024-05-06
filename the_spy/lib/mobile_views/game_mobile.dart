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

  List<Widget> _stackChildren = [];

  @override
  void initState() {
    final Random rm = Random();
    for (int i = 0; i < widget.numberSpies; i++) {
      _spyNumbers.add(rm.nextInt(widget.numberPlayer) + 1);
    }
    _generateCards();
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
    return Center(
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: _stackChildren,
      ),
    );
  }

  void _generateCards() {
    Size size = MediaQuery.of(context).size;
    for (int i = 0; i < widget.numberPlayer; i++) {
      _stackChildren.add(
        GestureDetector(
          onTap: () {
            // TODO: check if that is really working
            _stackChildren.removeAt(i);
          },
          child: SizedBox(
            height: size.height / 2,
            width: size.width / 1.25,
            child: const DecoratedBox(
              decoration: BoxDecoration(),
              position: DecorationPosition.background,
              child: Text("Tap to unhide"),
            ),
          ),
        ),
      );
    }
  }
}
