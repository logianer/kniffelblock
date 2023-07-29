import 'package:flutter/material.dart';
import 'package:kniffelblock/main.dart';
import 'package:kniffelblock/provider.dart';
import 'package:provider/provider.dart';

class UpperSection extends StatefulWidget {
  const UpperSection(
      {super.key,
      required this.title,
      required this.multiplier,
      required this.icon,
      required this.playerIdx});

  final int playerIdx;
  final IconData icon;
  final String title;
  final int multiplier;

  @override
  State<UpperSection> createState() => _UpperSectionState();
}

class _UpperSectionState extends State<UpperSection> {
  List<int> _upperSection = [];
  double _currentValue = 0;
  bool _isStriked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _upperSection = Provider.of<PlayerProvider>(context, listen: false)
          .getPlayer(widget.playerIdx)
          .getUpperSection();
      if (_upperSection[widget.multiplier - 1].toDouble() < 0) {
        _currentValue = 0;
        _isStriked = true;
      } else {
        _currentValue = _upperSection[widget.multiplier - 1].toDouble();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _upperSection = Provider.of<PlayerProvider>(context, listen: true)
        .getPlayer(widget.playerIdx)
        .getUpperSection();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Icon(widget.icon),
            const SizedBox(width: 4.0),
            Text(widget.title),
          ],
        ),
      ),
      body: Consumer<PlayerProvider>(
        builder: (context, players, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: labelText('Anzahl: ${_currentValue.round()}', context),
              ),
              Slider(
                value: _currentValue,
                label: _currentValue.round().toString(),
                onChanged: (_isStriked)
                    ? null
                    : (value) {
                        setState(() {
                          _currentValue = value;
                          _upperSection[widget.multiplier - 1] =
                              _currentValue.toInt();
                          players.setPlayerData(widget.playerIdx,
                              PlayerDataPath.upper, _upperSection);
                        });
                      },
                min: 0,
                max: 5,
                divisions: 5,
              ),
              SwitchListTile(
                  title: const Text('Streichen?'),
                  value: _isStriked,
                  onChanged: (value) {
                    setState(() {
                      _isStriked = value;
                      if (_isStriked) {
                        _currentValue = 0;
                      }
                      _upperSection[widget.multiplier - 1] = (_isStriked) ? -1 : 0;
                      players.setPlayerData(widget.playerIdx,
                          PlayerDataPath.upper, _upperSection);
                    });
                  }),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1.5 + .25 * _currentValue,
                          color: Theme.of(context).colorScheme.primary)),
                  child: Center(
                    child: Text(
                      (_currentValue.round() * widget.multiplier).toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
