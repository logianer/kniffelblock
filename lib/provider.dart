import 'package:flutter/material.dart';

enum PlayerDataPath { upper, lower }

class Player {
  final int index;
  String? name;
  List<int> _upperSection = List<int>.filled(6, -1);
  List<int> _lowerSection = List<int>.filled(7, 0);

  Player({required this.index, this.name}) {
    name ??= 'Spieler $index';
  }
  List<int> getLowerSection() {
    return _lowerSection;
  }

  List<int> getUpperSection() {
    return _upperSection;
  }

  List<int> setUpperSection(List<int> upper) {
    _upperSection = upper;
    return _upperSection;
  }

  List<int> setLowerSection(List<int> lower) {
    _lowerSection = lower;
    return _lowerSection;
  }
}

class PlayerProvider extends ChangeNotifier {
  final List<Player> _players = [];

  List<Player> addPlayer([String? name]) {
    _players.add(Player(index: _players.length + 1, name: name));
    notifyListeners();
    return _players;
  }
  List<Player> allPlayers() {
    return _players;
  }
  List<Player> removePlayerAt(int index) {
    _players.removeAt(index);
    notifyListeners();
    return _players;
  }

  List<Player> removePlayer(String name) {
    int index = _players.indexWhere((player) => player.name == name);
    return removePlayerAt(index);
  }

  Player getPlayer(int index) {
    if (index < 0 || index >= _players.length) return Player(index: -1);
    return _players[index];
  }

  Player setPlayerData(int index, PlayerDataPath path,
      List<int> data) {
    if (index < 0 || index >= _players.length) return Player(index: -1);
    Player player = getPlayer(index);
    switch (path) {
      case PlayerDataPath.upper:
        player.setUpperSection(data);
        break;
      case PlayerDataPath.lower:
        player.setLowerSection(data);
        break;
    }
    _players[index] = player;
    notifyListeners();
    return _players[index];
  }
}
