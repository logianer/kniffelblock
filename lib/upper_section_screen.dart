import 'package:flutter/material.dart';
import 'package:kniffelblock/main.dart';

class UpperSection extends StatefulWidget {
  const UpperSection({super.key, required this.title, required this.multiplier});

  final String title;
  final int multiplier;
  @override
  State<UpperSection> createState() => _UpperSectionState();
}

class _UpperSectionState extends State<UpperSection> {
  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: labelText('Anzahl: ${_currentSliderValue.round()}', context),
          ),
          Slider(
            value: _currentSliderValue,
            label: _currentSliderValue.round().toString(),
            onChanged: (value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
            min: 0,
            max: 6,
            divisions: 6,
          ),
          Center(
            child: Container(
              height: 50,
              width: 50,
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1.5+.25*_currentSliderValue, color: Theme.of(context).primaryColor)
              ),
              child: Center(
                child: Text((_currentSliderValue.round()*widget.multiplier).toString(), style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
