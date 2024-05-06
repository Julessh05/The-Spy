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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
