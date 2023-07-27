import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kniffelblock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Kniffel'),
      ),
      body: ListView(
        children: const [ObenDisplay(), UntenDisplay()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {},
        tooltip: 'Zeige Spieler',
        child: const Icon(Icons.backup_table),
      ),
    );
  }
}

Widget labelText(String text, BuildContext ctx) {
  return Text(text,
      style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
          color: Theme.of(ctx).primaryColor, fontWeight: FontWeight.w600));
}

class ObenDisplay extends StatefulWidget {
  const ObenDisplay({super.key});

  @override
  State<ObenDisplay> createState() => _ObenDisplayState();
}

Widget tappableListItem(
    {required String text,
    required IconData leadingIcon,
    String? description,
    dynamic tapEvent}) {
  return ListTile(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        if (description != null)
          Text(description,
              style: const TextStyle(color: Colors.grey, fontSize: 14.0))
      ],
    ),
    leading: Icon(leadingIcon,color: Colors.orange  ),
    trailing: const Icon(Icons.chevron_right_rounded),
    onTap: () {
      tapEvent();
    },
  );
}

class _ObenDisplayState extends State<ObenDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: labelText('Oben', context),
          ),
          tappableListItem(
              text: '1er',
              description: 'nur Einser zählen',
              leadingIcon: Icons.looks_one_rounded),
          tappableListItem(
              text: '2er',
              description: 'nur Zweier zählen',
              leadingIcon: Icons.looks_two_rounded),
          tappableListItem(
              text: '3er',
              description: 'nur Dreier zählen',
              leadingIcon: Icons.looks_3_rounded),
          tappableListItem(
              text: '4er',
              description: 'nur Vierer zählen',
              leadingIcon: Icons.looks_4_rounded),
          tappableListItem(
              text: '5er',
              description: 'nur Fünfer zählen',
              leadingIcon: Icons.looks_5_rounded),
          tappableListItem(
              text: '6er',
              description: 'nur Sechser zählen',
              leadingIcon: Icons.looks_6_rounded)
        ]);
  }
}

class UntenDisplay extends StatelessWidget {
  const UntenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
        child: labelText('Unten', context),
      ),
      tappableListItem(
          text: 'Dreierpasch',
          description: 'Alle Augen zählen',
          leadingIcon: Icons.casino_outlined),
      tappableListItem(
          text: 'Viererpasch',
          description: 'alle Augen zählen',
          leadingIcon: Icons.casino_outlined),
      tappableListItem(
          text: 'Full House',
          description: '25 Punkte',
          leadingIcon: Icons.house_rounded),
      tappableListItem(
          text: 'Kleine Straße',
          description: '30 Punkte',
          leadingIcon: Icons.signpost_rounded),
      tappableListItem(
          text: 'Große Straße',
          description: '40 Punkte',
          leadingIcon: Icons.signpost_rounded),
      tappableListItem(
          text: 'Kniffel',
          description: '50 Punkte',
          leadingIcon: Icons.casino_rounded),
      tappableListItem(
          text: 'Chance',
          description: 'alle Augen zählen',
          leadingIcon: Icons.restart_alt_rounded),
      const Padding(padding: EdgeInsets.only(bottom: 16.0))
    ]);
  }
}
