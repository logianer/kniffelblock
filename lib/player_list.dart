import 'package:flutter/material.dart';
import 'package:kniffelblock/main.dart';
import 'package:kniffelblock/provider.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> _playerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _playerList =
          Provider.of<PlayerProvider>(context, listen: false).allPlayers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _playerList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(index.toString()),
              title: Text(_playerList[index].name ?? ''),
              subtitle: Text(_playerList[index].getUpperSection().toString()),
            );
          }),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton.small(
          heroTag: 'secondaryFab',
            child: const Icon(Icons.add_rounded),
            onPressed: () {
              _playerList = Provider.of<PlayerProvider>(context, listen: false)
                  .addPlayer();
              setState(() {});
            }),
        const SizedBox(height: 12),
        FloatingActionButton(
            child: const Icon(Icons.edit_rounded),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            })
      ]),
    );
  }
}
