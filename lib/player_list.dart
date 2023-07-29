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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Kniffel'),
      ),
      body: _playerList.isNotEmpty ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250,childAspectRatio: 2/3),
        itemCount: _playerList.length,
        itemBuilder: (BuildContext context, int index) {
          int sum =
              _playerList[index].getScores().sublist(0, 6).reduce((value, element) => value + element);
          int sum2 =
          _playerList[index].getScores().sublist(6, 13).reduce((value, element) => value + element);
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              playerId: index,
                              playerData: _playerList[index],
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person_rounded),
                      title: Text(_playerList[index].name ?? '', style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0
                      )),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: const Icon(Icons.functions_rounded),
                      title: Text('Oberer Teil: ${sum.toString()}'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: const Icon(Icons.functions_rounded),
                      title: Text('Unterer Teil: ${sum2.toString()}'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: const Icon(Icons.calculate_rounded),
                      title: Text('Gesamt: ${(sum+sum2).toString()}'),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            tooltip: 'Spieler löschen',
                            onPressed: () {
                              Provider.of<PlayerProvider>(context, listen: false).removePlayerAt(index);
                              setState((){});
                            },
                            icon: const Icon(Icons.delete_rounded)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ) : const Center(
        child: Text('Keine Spieler vorhanden.'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add_rounded),
          onPressed: () {
            _playerList =
                Provider.of<PlayerProvider>(context, listen: false).addPlayer();
            setState(() {});
          }),
    );
  }
}
